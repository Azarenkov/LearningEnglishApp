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
            self.alertMessage = "Все поля должны быть заполнены."
            self.showAlert = true
        } else {
            FirebaseManager.shared.firestore.collection("topics")
                .addDocument(data: topicData) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        self.alertMessage = "Ошибка при добавлении темы."
                    } else {
                        print("Document added successfully")
                        self.alertMessage = "Тема успешно добавлена!"
                        self.clearFields()
                    }
                    self.showAlert = true
                }
        }
    }

    private func clearFields() {
        self.title = ""
        self.text = ""
        self.russian = ""
    }
}

class AdminViewModel: ObservableObject {
    private var db = Firestore.firestore()

    func addTest(title: String) {
        let test = [
            "title": title
        ]
        db.collection("tests").document(title).setData(test) { error in
            if let error = error {
                print("Error adding test: \(error)")
            } else {
                print("Test successfully added")
            }
        }
    }

    func addQuestion(toTest testTitle: String, text: String, answer: String) {
        let question = [
            "text": text,
            "answer": answer
        ]
        db.collection("tests").document(testTitle).collection("test").addDocument(data: question) { error in
            if let error = error {
                print("Error adding question: \(error)")
            } else {
                print("Question successfully added to test \(testTitle)")
            }
        }
    }
}
