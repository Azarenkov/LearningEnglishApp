//
//  ResultsViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 01.05.2024.
//

import Foundation

class ResultsViewModel: ObservableObject {
    
    @Published var results: [Results] = []

    func getPrivacy() {
        let docRef = FirebaseManager.shared.firestore.collection("results").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.results = documents.compactMap { document in
                    do {
                        return try document.data(as: Results.self)
                    } catch {
                        print("Error decoding task: \(error)")
                        return nil
                    }
                }
            }
        }
    }
}
