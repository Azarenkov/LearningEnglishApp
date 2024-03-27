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
    
    @Published var topic: Topic?
    @Published var topics: [Topic] = []
    
    init() {
        getTopic()
    }
    
    

    
    func getTopic() {
        let docRef = FirebaseManager.shared.firestore.collection("topics").document("2KqwIbemgFVjnHLX7Rda")
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.topic = try document.data(as: Topic.self)
                } catch {
                    print("Error decoding topic: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}

class TopicViewModel2: ObservableObject {
    
    @Published var topic: Topic?
    
    init() {
        getTopic()
    }
    
    func getTopic() {
        let docRef = FirebaseManager.shared.firestore.collection("topics").document("xnIGwAkX74JyvV5Wuq82")
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.topic = try document.data(as: Topic.self)
                } catch {
                    print("Error decoding topic: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
