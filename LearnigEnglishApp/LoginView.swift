//
//  ContentView.swift
//  LearnigEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    
//    let didCompleteLoginProcess: () -> ()
    
    @State private var shouldShowMainView = false
        
    @State private var isLoginMode = false
    @State private var nickname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State var loginStatusMessage = ""
    
    var body: some View {
//        NavigationView {
            VStack {
                HStack {
                    Text(isLoginMode ? "Login" : "Sign Up")
                        .font(.bold(.largeTitle)())
                    Spacer()
                }
                Picker(selection: $isLoginMode, label: Text("Picker")) {
                    Text("Login")
                        .tag(true)
                    Text("Sign Up")
                        .tag(false)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                logo
                
                Spacer()
                
                textFields
                
                Spacer()
                
                Button {
                    
                    fetchRequest()
                    
                } label: {
                    Text(isLoginMode ? "Login" : "Sign Up")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Result"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .fullScreenCover(isPresented: $shouldShowMainView, onDismiss: nil) {
                                MainView()
            }
//        }
    }
    
    private var textFields: some View {
        
        VStack(spacing: 25) {
            Group {
                if !isLoginMode {
                    TextField("Nickame", text: $nickname)
                }
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.horizontal)
        }
    }
    
    private var logo: some View {
        
        if colorScheme == .dark {
            Image("Artboard 8")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 100)
                .clipped()
        } else {
            Image("Artboard 7")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 100)
                .clipped()
        }
    }
    
    func fetchRequest() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                self.loginStatusMessage = "Failed to login user: \(err.localizedDescription)"
                alertMessage = loginStatusMessage
                showAlert.toggle()
                return
            }
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
            
            shouldShowMainView.toggle()
        }
    }
    
    private func createNewAccount() {
        
        if nickname.isEmpty {
            self.loginStatusMessage = "You must select a nickname"
            alertMessage = loginStatusMessage
            showAlert.toggle()
            return
        }
        
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
//              print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create: \(err.localizedDescription)"
                alertMessage = loginStatusMessage
                showAlert.toggle()
                return
            }
//    print("Successfully created user: \(result?.user.uid ?? "")")
            
            storeUserInformation(nickname: nickname)
            self.loginStatusMessage = "Successfully created user"
            alertMessage = loginStatusMessage
            showAlert.toggle()
        }
    }
    
    private func storeUserInformation(nickname: String) {
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

struct LoginView_Prewiews: PreviewProvider {
    static var previews: some View {
        LoginView(

        )
    }
}
