//
//  MainView.swift
//  EnglishXForVkr
//
//  Created by Алексей Азаренков on 23.02.2024.
//

import SwiftUI

struct MainView: View {
    
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
                    
                TestsListView()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Tests")
                    }
                    .tag(1)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(2)
            }
            .navigationTitle(vm.navigationTitle(for: selectedTab))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

