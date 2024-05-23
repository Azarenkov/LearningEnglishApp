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

    @State private var useSystemSetting = true
    @State private var selectedScheme: ColorSchemeOption = .system
    
    @State private var shouldShowLogOutOptions = false

    @State var shouldShowMainView = UserDefaults.standard.bool(forKey: "shouldShowMainView")
    
    @State private var showLoginView = false

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
                        Text("Log Out")
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
                    UserDefaults.standard.shouldShowGoogleInfo = false
                    
                    shouldShowMainView = false
                    UserDefaults.standard.set(shouldShowMainView, forKey: "shouldShowMainView")
                    
                    showLoginView.toggle()
                }),
                .cancel()
            ])
        }
        
        .fullScreenCover(isPresented: $showLoginView, onDismiss: nil) {
            LoginView()
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch selectedScheme {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

#Preview {
    MainView()
//    ProfileView()
}
