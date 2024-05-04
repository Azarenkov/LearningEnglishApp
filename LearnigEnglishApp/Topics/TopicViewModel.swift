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
    @Published var topics: [Topic] = []
    
    init() {
        getTopics()
    }

    func getTopics() {
        let docRef = FirebaseManager.shared.firestore.collection("topics")
        docRef.getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var fetchedTopics: [Topic] = []
                for document in querySnapshot?.documents ?? [] {
                    print("Document data: \(document.data())")  
                    let data = document.data()
                    let id = document.documentID
                    let title = data["title"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let russian = data["russian"] as? String ?? ""
                    let topic = Topic(id: id, title: title, text: text, russian: russian)
                    fetchedTopics.append(topic)
                }
                DispatchQueue.main.async {
                    self.topics = fetchedTopics
                    print("Fetched topics count: \(fetchedTopics.count)")
                }
            }
        }
    }
}
