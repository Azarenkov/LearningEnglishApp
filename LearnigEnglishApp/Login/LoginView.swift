//
//  ContentView.swift
//  LearnigEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import Foundation
import FirebaseCore


struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @FocusState private var focus: FormFieldFocus?
    
    @AppStorage("shouldShowGoogleInfo")
    var shouldShowGoogleInfo = false
    
    @AppStorage("welcomeScreenShown")
    var welcomeScreenShown: Bool = false
        
    @ObservedObject private var vm = LoginViewModel()
    
    var body: some View {
        ZStack {
            linear
            if UserDefaults.standard.welcomeScreenShown {
                VStack {
                    HStack {
                        Text(vm.isLoginMode ? "Login" : "Sign Up")
                            .font(.bold(.largeTitle)())
                        Spacer()
                    }
                    
                    Picker(selection: $vm.isLoginMode, label: Text("Picker")) {
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
                        
                        vm.fetchRequest()
                        
                    } label: {
                        Text(vm.isLoginMode ? "Login" : "Sign Up")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(100)
                    }
                    .shadow(radius: 10)
                    
                    Text("Or continue with")
                        .font(.caption)
                        .bold()
                        .padding(.top, 30)
                        .padding(.bottom, 5)
                    
                    GoogleSignInButton {
                        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

                        let config = GIDConfiguration(clientID: clientID)
                        GIDSignIn.sharedInstance.configuration = config

                        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
                          guard error == nil else {
                              return
                          }

                          guard let user = result?.user,
                            let idToken = user.idToken?.tokenString
                          else {
                              return
                          }

                          let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                            
                            Auth.auth().signIn(with: credential) { result, error in
                                guard error == nil else {
                                    return
                                }
                                vm.shouldShowMainView.toggle()
                                shouldShowGoogleInfo.toggle()
                                UserDefaults.standard.shouldShowGoogleInfo.toggle()
                            }
                        }
                    }
                }
                .padding()
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Result"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK")))
                }
                
                .fullScreenCover(isPresented: $vm.shouldShowAdminView, onDismiss: nil) {
                    AdminView()
                }
                
                
                .fullScreenCover(isPresented: $vm.shouldShowMainView, onDismiss: nil) {
                    MainView()
                }
            } else {
                WelcomeView()
            }
        }
    }
    
    private var textFields: some View {
        
        VStack(spacing: 25) {
            Group {
                if !vm.isLoginMode {
                    TextField("Nickame", text: $vm.nickname)
                        .onSubmit {
                            focus = .email
                        }
                        .focused($focus, equals: .nickname)
                    
                }
                
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .onSubmit {
                        focus = .password
                    }
                    .focused($focus, equals: .email)
                
                SecureField("Password", text: $vm.password)
                    .focused($focus, equals: .password)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(15)
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
    
    private var linear: some View {
        if colorScheme == .dark {
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white, Color.cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
}


extension UserDefaults {
    var shouldShowGoogleInfo: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "shouldShowGoogleInfo") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "shouldShowGoogleInfo")
        }
    }
}

struct LoginView_Prewiews: PreviewProvider {
    static var previews: some View {
        LoginView(

        )
    }
}

struct GoogleSignInButton: View {
    
    var action: () -> Void
    var body: some View {
        Button {
            action()
       } label: {
           ZStack {
               Image("Google")
                   .resizable()
                   .frame(width: 30, height: 30)
           }
           .frame(width: 70, height: 50)
           .background(Color.clear)
           .cornerRadius(15)
           .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray), lineWidth: 1.5)
           )
       }
       .shadow(radius: 0)

    }
}
