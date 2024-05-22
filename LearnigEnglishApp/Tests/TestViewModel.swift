//
//  TestViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 04.05.2024.
//

import Foundation
import Firebase

class TestsViewModel: ObservableObject {
    @Published var tests: [Test] = []
    @Published var testItems: [TestItem] = []
    @Published var currentTestItem: TestItem?
    @Published var result: Int = 0
    @Published var showResult: Bool = false
    private var currentIndex = 0
    private var db = Firestore.firestore()

    init() {
        fetchTestList()
    }

    func fetchTestList() {
        db.collection("tests").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.tests = querySnapshot.documents.map { document -> Test in
                    let id = document.documentID
                    let title = document.data()["title"] as? String ?? "No Title"
                    return Test(id: id, title: title)
                }
            }
        }
    }

    func loadQuestions(testId: String) {
        testItems.removeAll()
        result = 0
        showResult = false

        db.collection("tests").document(testId).collection("test").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let querySnapshot = querySnapshot {
                self.testItems = querySnapshot.documents.compactMap { document -> TestItem? in
                    let data = document.data()
                    guard let text = data["text"] as? String,
                          let answer = data["answer"] as? String else {
                        return nil
                    }
                    return TestItem(id: document.documentID, text: text, answer: answer)
                }
                self.currentIndex = 0
                self.currentTestItem = self.testItems.first
            }
        }
    }


    func checkAnswer(userAnswer: String) {
        if let currentTestItem = currentTestItem, currentTestItem.answer.lowercased() == userAnswer.lowercased() {
            result += 1
        }
        moveToNextQuestion()
    }

    private func moveToNextQuestion() {
        if currentIndex < testItems.count - 1 {
            currentIndex += 1
            currentTestItem = testItems[currentIndex]
        } else {
            showResult = true
            storeResult(result: result)
        }
    }
    
    func storeResult(result: Int) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let timestamp = Date()
        
        let resultData = [
            "result": result,
            "tests": testItems.count,
            "uid": uid,
            "timestamp": timestamp
        ] as [String: Any]
        
        FirebaseManager.shared.firestore.collection("results")
            .addDocument(data: resultData) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added successfully")
                }
            }
    }
}
