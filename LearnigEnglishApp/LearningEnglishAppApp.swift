//
//  LearnigEnglishAppApp.swift
//  LearnigEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import SwiftUI

@main
struct LearningEnglishAppApp: App {
    
    @ObservedObject private var vm = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            if vm.isUserCurrentlyLoggedOut {
                LoginView()
            } else {
                MainView()
            }
        }
    }
}
