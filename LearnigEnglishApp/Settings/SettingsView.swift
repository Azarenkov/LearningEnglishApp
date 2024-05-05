//
//  SettingsView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 05.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var vm = MainViewModel()
    
//    @Binding var shouldShowLogOutOptions: Bool
    
    @State var shouldShowLogOutOptions = false
    @State var shouldShowLoginView = false

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
                    ResultsView()
                        .navigationTitle("Your statistics")
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
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign out"), action: {
                    print("handle sign out")
                    vm.handleSignOut()
                    shouldShowLoginView.toggle()
                }),
                .cancel()
            ])
        }
        
        .fullScreenCover(isPresented: $shouldShowLoginView) {
            LoginView()
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
            
            Spacer()
            
            logo
                .padding(.vertical)
            
            Spacer()
            
            TextField("Name", text: $nickname)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding()
            
            
            Button {
                vm.updateName(nickname: nickname)
                nickname = ""
            } label: {
                Text("Submit")
            }
            .buttonStyle(.borderedProminent)
            .shadow(radius: 4)
            .padding()
            
            Spacer()
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Result"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            })
            )
        }
        .navigationTitle("Name Changing")
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
            
            Spacer()
            
            logo
                .padding(.vertical)
            
            Spacer()
            
            TextField("Password", text: $password)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding()
            
            Button {
                vm.updatePassword(password: password)
                password = ""
            } label: {
                Text("Submit")
            }
            .buttonStyle(.borderedProminent)
            .shadow(radius: 4)
            .padding()
            
            Spacer()
        }
        
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Result"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .navigationTitle("Password Changing")
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
                Section {
                    Text(privacy.text)
                        .font(.callout)
                        .padding(8)
                }
                
                Section(header: Text("Руководство пользователя")) {
                    Text(privacy.text2)
                        .font(.callout)
                        .padding(8)
                }
            } else {
                ProgressView()
            }
        }
    }
}



#Preview {
    MainView()
}
