//
//  MainView.swift
//  EnglishXForVkr
//
//  Created by Алексей Азаренков on 23.02.2024.
//

import SwiftUI

struct MainView: View {
    
//    init() {
//        UITabBar.appearance().backgroundColor = .systemGray6
//    }
    
    @ObservedObject private var vm = MainViewModel()
    
    @State var shouldShowTopicView = false
    @State private var shouldShowTabView = true
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            
            TabView(selection: $selectedTab) {
                TopicsView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Topics")
                    }
                    .tag(0)
                    
                TasksView()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Tasks")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(2)
            }
//            .actionSheet(isPresented: $shouldShowLogOutOptions) {
//                .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
//                    .destructive(Text("Sign out"), action: {
//                        print("handle sign out")
//                        vm.handleSignOut()
//                        shouldShowLoginView.toggle()
//                    }),
//                    .cancel()
//                ])
//            }
//            
//            .fullScreenCover(isPresented: $shouldShowLoginView) {
//                LoginView()
//            }
            
            .navigationTitle(vm.navigationTitle(for: selectedTab))
        }
    }
}

#Preview {
    MainView()
}
