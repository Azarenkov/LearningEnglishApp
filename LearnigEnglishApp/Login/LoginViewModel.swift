//
//  LoginViewModel.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 04.05.2024.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class LoginViewModel: ObservableObject {
    
    @Published var shouldShowMainView = false
    @Published var shouldShowAdminView = false
        
    @Published var isLoginMode = false
    @Published var nickname = ""
    @Published var email = ""
    @Published var password = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    @Published var loginStatusMessage = ""
    
    
    func fetchRequest() {
        if isLoginMode {
            if email == "admin" && password == "1111" {
                shouldShowAdminView.toggle()
            } else {
                loginUser()
            }
        } else {
            createNewAccount()
        }
    }
    
    func loginUser() {
        
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                self.loginStatusMessage = "Failed to login user: \(err.localizedDescription)"
                self.alertMessage = self.loginStatusMessage
                self.showAlert.toggle()
                return
            }
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            self.shouldShowMainView.toggle()
        }
    }
    
    func createNewAccount() {
        
        if nickname.isEmpty {
            self.loginStatusMessage = "You must select a nickname"
            alertMessage = loginStatusMessage
            showAlert.toggle()
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                self.loginStatusMessage = "Failed to create: \(err.localizedDescription)"
                self.alertMessage = self.loginStatusMessage
                self.showAlert.toggle()
                return
            }
            
            self.storeUserInformation(nickname: self.nickname)
            self.loginStatusMessage = "Successfully created user"
            self.alertMessage = self.loginStatusMessage
            self.nickname = ""
            self.email = ""
            self.password = ""
            self.showAlert.toggle()
        }
    }
    
    func storeUserInformation(nickname: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": self.email, "uid": uid, "nickname": self.nickname]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    self.loginStatusMessage = "\(err.localizedDescription)"
                    return
                }
                print("success")
            }
    }
}
