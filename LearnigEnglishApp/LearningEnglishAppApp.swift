//
//  LearnigEnglishAppApp.swift
//  LearnigEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import SwiftUI

@main
struct LearningEnglishAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @ObservedObject private var vm = MainViewModel()
    
    var shouldShowMainView = UserDefaults.standard.bool(forKey: "shouldShowMainView")

    
    var body: some Scene {
        WindowGroup {
            if shouldShowMainView {
                MainView()
            } else {
                if UserDefaults.standard.welcomeScreenShown {
                    LoginView()
                } else {
                    WelcomeView()
                }
            }
        }
    }
}
