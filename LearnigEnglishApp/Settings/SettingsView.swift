//
//  SettingsView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 05.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var vm = MainViewModel()
    
    @Binding var shouldShowLogOutOptions: Bool

    var body: some View {
        Form {
            
            Section(header: Text("Information")) {
                
                NavigationLink {
                    ProfileView()
                        .navigationTitle("Profile")
                } label: {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                
                NavigationLink {
                    
                } label: {
                    Image(systemName: "medal")
                    Text("Results")
                }
                
                
                NavigationLink {
                    PrivacyView()
                        .navigationTitle("Privacy & Security")
                } label: {
                    Image(systemName: "info.circle")
                    Text("Privacy & Security")
                }
            }
            
            Section {
                Button {
                    //                        vm.handleSignOut()
                    shouldShowLogOutOptions.toggle()
                } label: {
                    Text("Log out")
                }
                
                
            }
            
        }

    }
}

struct ProfileView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
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

struct NameView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    @State private var nickname = ""

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            logo
                .padding(.vertical)
            TextField("Name", text: $nickname)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding()
            
            
            Button {
                vm.updateName(nickname: nickname)
                //presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit")
            }
            .buttonStyle(.borderedProminent)
            
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Result"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
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

struct PasswordView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    @State private var password = ""

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        VStack {
            logo
                .padding(.vertical)
            
            TextField("Password", text: $password)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding()
            
            Button {
                vm.updatePassword(password: password)
                //                    presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Submit")
            }
            .buttonStyle(.borderedProminent)
        }
        
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Result"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
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

struct PrivacyView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    var body: some View {
        Form {
            if let privacy = vm.privacy {
                Text(privacy.text)
                    .font(.callout)
                    .padding(8)
            } else {
                ProgressView()
            }
        }
    }
}



#Preview {
    MainView()
}
