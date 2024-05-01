//
//  TopicViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 19.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TopicViewModel: ObservableObject {
    
//    @Published var topic: Topic?
    @Published var topics: [Topic] = []
    
    init() {
        getTopic()
    }
    
    func getTopic() {
        let docRef = FirebaseManager.shared.firestore.collection("topics")
        
        docRef.addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.topics = documents.compactMap { document in
                    do {
                        var resultData = try document.data(as: Topic.self)
                        resultData.id = document.documentID
                        return resultData
                    } catch {
                        print("Error decoding task: \(error)")
                        return nil
                    }
                }
            }
    }
}
