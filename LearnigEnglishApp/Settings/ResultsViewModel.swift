//
//  ResultsViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 01.05.2024.
//

import Foundation

class ResultsViewModel: ObservableObject {
    
    @Published var results: [Results] = []
    @Published var averageScore: Double?
    
    func getResult() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let docRef = FirebaseManager.shared.firestore.collection("results")
        
        docRef.whereField("uid", isEqualTo: uid)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.results = documents.compactMap { document in
                    do {
                        var resultData = try document.data(as: Results.self)
                        resultData.id = document.documentID
                        return resultData
                    } catch {
                        print("Error decoding task: \(error)")
                        return nil
                    }
                }
                self.calculateAverageScore()
            }
    }
    
    private func calculateAverageScore() {
        // Вычисление общего количества результатов и общего количества пройденных тестов
        let totalResults = results.reduce(0) { $0 + $1.result }
        let totalTasks = results.reduce(0) { $0 + $1.tests }
        
        // Если общее количество пройденных тестов больше нуля, вычисляем средний балл
        if totalTasks > 0 {
            averageScore = Double(totalResults) / Double(totalTasks)
        } else {
            averageScore = nil
        }
    }
}
