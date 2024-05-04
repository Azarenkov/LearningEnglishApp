//
//  AdminViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 05.05.2024.
//

import Foundation
import Firebase

class AdminTopicViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var text = ""
    @Published var russian = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func storeTopicInformation() {
        let topicData = ["title": self.title, "text": self.text, "russian": self.russian]
        
        if title.isEmpty || text.isEmpty || russian.isEmpty {
            self.alertMessage = "Вам нужно добавить информацию"
            self.showAlert.toggle()
        } else {
            FirebaseManager.shared.firestore.collection("topics")
                .addDocument(data: topicData) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added successfully")
                        self.alertMessage = "Ваша тема для изучения добавлена"
                        self.showAlert.toggle()
                        self.title = ""
                        self.russian = ""
                        self.text = ""
                    }
                }
        }
    }
}
