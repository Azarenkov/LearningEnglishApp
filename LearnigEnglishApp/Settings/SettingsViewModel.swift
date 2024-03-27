//
//  SettingsViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 05.03.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class SettingsViewModel: ObservableObject {
    
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var privacy: Privacy?
    
    init() {
        fetchCurrentUser()
        getPrivacy()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            self.user = try? snapshot?.data(as: User.self)
            FirebaseManager.shared.currentUser = self.user
        }
    }
    
    func updateName(nickname: String) {
        
        if nickname.isEmpty {
            self.errorMessage = "You must select a nickname"
            self.showAlert.toggle()            
            return
        }

        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        let userRef = FirebaseManager.shared.firestore.collection("users").document(uid)
        
        userRef.updateData([
                    "nickname": nickname
                ]) { error in
                    if let error = error {
                        self.errorMessage = "Error updating name: \(error.localizedDescription)"
                        self.showAlert.toggle()
                        print("Error updating name:", error)
                    } else {
                        self.errorMessage = "Name updated successfully!"
                        print("Name updated successfully!")
                        self.showAlert.toggle()
                        self.fetchCurrentUser()
                    }
                }
    }
    
    func updatePassword(password: String) {
                
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if let error = error {
                self.errorMessage = "Error updating password: \(error.localizedDescription)"
                self.showAlert.toggle()
            } else {
                self.errorMessage = "Password updated successfully!"
                self.showAlert.toggle()
                print("Password updated successfully!")
                self.fetchCurrentUser()
            }
        }
    }
    
    func getPrivacy() {
        let docRef = FirebaseManager.shared.firestore.collection("privacy").document("8afXJe46Apd5qGltjhYC")
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                do {
                    self.privacy = try document.data(as: Privacy.self)
                } catch {
                    print("Error decoding privacy: \(error)")
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    
    
}
