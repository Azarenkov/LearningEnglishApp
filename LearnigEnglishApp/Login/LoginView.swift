//
//  ContentView.swift
//  LearnigEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
        
    @ObservedObject private var vm = LoginViewModel()
    
    var body: some View {
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
            }
            .buttonStyle(.borderedProminent)
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
    }
    
    private var textFields: some View {
        
        VStack(spacing: 25) {
            Group {
                if !vm.isLoginMode {
                    TextField("Nickame", text: $vm.nickname)
                }
                
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $vm.password)
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
}

struct LoginView_Prewiews: PreviewProvider {
    static var previews: some View {
        LoginView(

        )
    }
}
