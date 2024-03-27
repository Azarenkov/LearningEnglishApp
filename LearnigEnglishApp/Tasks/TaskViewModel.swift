//
//  TaskViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 30.04.2024.
//

import Foundation

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskViewModel: ObservableObject {
  
    @Published var showResultOptions = false
    @Published var tasks: [Tasks] = []
    @Published var currentTask: Tasks? {
        didSet {
            objectWillChange.send() // Это вызывает обновление представления при изменении currentTask
        }
    }
    var currentIndex = 0
    @Published var answer: String = ""
    var result = 0
    
    init() {
        getTasks()
    }
    
    func getTasks() {
        FirebaseManager.shared.firestore.collection("tasks").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.tasks = documents.compactMap { document in
                    do {
                        return try document.data(as: Tasks.self)
                    } catch {
                        print("Error decoding task: \(error)")
                        return nil
                    }
                }
                self.currentTask = self.tasks.first // Устанавливаем первое задание по умолчанию
            }
        }
    }
    
    func getNextTask() {
        currentIndex += 1
        if currentIndex >= tasks.count {
            currentIndex = 0 // Loop back to the first task if reached the end
            self.showResultOptions.toggle()
            storeResult(result: result)
 
        } else {
            currentTask = tasks.isEmpty ? nil : tasks[currentIndex] // Обновляем currentTask
            answer = "" // Очищаем значение ответа после перехода к следующему заданию
            objectWillChange.send() // вызываем objectWillChange.send() для обновления представления
        }
    }
        
    
    func sumResult() {
        guard let currentTask = currentTask else {
            print("No current task")
            return
        }
        
        if currentTask.answer.lowercased() == answer.lowercased() {
            // Increase result if the answer is correct
            result += 1
            print("Correct!")
            print(result)
        } else {
            // Handle incorrect answer
            print("Incorrect!")
        }
    }
    
    func storeResult(result: Int) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        let resultData = ["result": self.result, "uid": uid] as [String : Any]
        FirebaseManager.shared.firestore.collection("results")
            .document().setData(resultData) { err in
                if let err = err {
                    
                    return
                }
                print("success")
            }
    }
}
