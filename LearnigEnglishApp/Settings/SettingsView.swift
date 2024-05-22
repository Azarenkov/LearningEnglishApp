//
//  SettingsView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 05.03.2024.
//

import SwiftUI
@testable import SettingsIconGenerator

struct SettingsView: View {
    @ObservedObject private var vm = MainViewModel()
//    @ObservedObject private var vm2 = LoginViewModel()
//    @Environment(\.colorScheme) var colorScheme
//    @Binding var shouldShowLogOutOptions: Bool
//    @State var colorMode = false
    @State private var useSystemSetting = true
    @State private var selectedScheme: ColorSchemeOption = .system
    
    @State var shouldShowLogOutOptions = false
    @State var shouldShowLoginView = false

    var body: some View {
        Form {
            
            Section(header: Text("Information"), footer: Text("Get information about your account and test results.")) {
                
                NavigationLink {
                    ProfileView()
                        .navigationTitle("Profile")
                } label: {
                    SettingsIcon(systemName: "person", backgroundColor: .purple)
                    Text("Profile")
                }
                
                NavigationLink {
                    ResultsView()
                        .navigationTitle("Your statistics")
                } label: {
                    SettingsIcon(systemName: "medal", backgroundColor: .blue)
                    Text("Results")
                }
            }
            
            Section(header: Text("App settings"), footer: Text("Select the application color mode.")) {
                HStack {
                    SettingsIcon(systemName: "moonphase.first.quarter", backgroundColor: .yellow)
                    
                    Picker("Color Scheme", selection: $selectedScheme) {
                        Text("Default").tag(ColorSchemeOption.system)
                        Text("Light").tag(ColorSchemeOption.light)
                        Text("Dark").tag(ColorSchemeOption.dark)
                    }
                }
            }
            
            Section(header: Text("Additional data"), footer: Text("We respect your privacy and are committed to protecting the information you provide to us.")) {
                NavigationLink {
                    PrivacyView()
                        .navigationTitle("Privacy & Security")
                } label: {
                    SettingsIcon(systemName: "info", backgroundColor: .green)
                    Text("Privacy & Security")
                }
            }
            
            Section {
                Button {
                    //                        vm.handleSignOut()
                    shouldShowLogOutOptions.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Log out")
                        Spacer()
                    }
                }
                .foregroundColor(.red)
            }
        }
        .preferredColorScheme(colorScheme)
        .animation(.default, value: selectedScheme)
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                .destructive(Text("Sign out"), action: {
                    print("handle sign out")
                    vm.handleSignOut()
                    UserDefaults.standard.shouldShowGoogleInfo.toggle()
                    shouldShowLoginView.toggle()
                }),
                .cancel()
            ])
        }
        
        .fullScreenCover(isPresented: $shouldShowLoginView) {
            LoginView()
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch selectedScheme {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

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
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(100)
            }
            .shadow(radius: 10)
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
            
            SecureField("Password", text: $password)
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
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(100)
            }
            .shadow(radius: 10)
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
//    ProfileView()
}
