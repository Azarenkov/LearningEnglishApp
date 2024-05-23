//
//  ProfileView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 25.05.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            if UserDefaults.standard.shouldShowGoogleInfo {
                ZStack {
                    Image("Google")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .padding()
                }
                
                Text("You are loggining with Google Account")
                    .font(.headline)
            } else {
                Form {
                    Section(header: Text("Email")) {
                        Text(vm.user?.email ?? "-")
                    }
                    
                    Section(header: Text("Name")) {
                        NavigationLink {
                            NameView()
                        } label: {
                            Text(vm.user?.nickname ?? "-")
                        }
                    }
                    
                    Section(header: Text("Password")) {
                        NavigationLink {
                            PasswordView()
                        } label: {
                            Text("******")
                        }
                    }
                }
                
                .onAppear {
                    vm.fetchCurrentUser()
                }
            }
        }
    }
}
