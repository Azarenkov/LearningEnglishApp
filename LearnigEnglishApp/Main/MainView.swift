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
    
    @State var shouldShowLogOutOptions = false
    @State var shouldShowTopicView = false
    @State var shouldShowLoginView = false
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
                
                SettingsView(shouldShowLogOutOptions: $shouldShowLogOutOptions)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(2)
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
            
            .navigationTitle(vm.navigationTitle(for: selectedTab))
        }
    }
}

struct TopicsView: View {
    
    @ObservedObject private var vm = TopicViewModel()
    @ObservedObject private var vm2 = TopicViewModel2()
    
    var body: some View {
        ScrollView {
            
            NavigationLink {
                TopicView()
                    .navigationTitle(vm.topic?.title ?? "Nothing")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 280, height: 150)
                        .foregroundColor(Color(.systemCyan))
                        .cornerRadius(15)
                    Text("1st")
                        .foregroundStyle(.white)
                        .font(.system(size: 55, weight: .thin, design: .rounded))
                }
            }
            .padding()
            .shadow(radius: 10)
            
            
            NavigationLink {
                TopicView2()
                    .navigationTitle(vm2.topic?.title ?? "Nothing")
            } label: {
                ZStack {
                    Rectangle()
                        .frame(width: 280, height: 150)
                        .foregroundColor(Color(.systemCyan))
                        .cornerRadius(15)
                    Text("2nd")
                        .foregroundStyle(.white)
                        .font(.system(size: 55, weight: .thin, design: .rounded))
                }
                
            }
            .padding()
            .shadow(radius: 10)
            
        }
    }
}

struct TasksView: View {
    
    var body: some View {
        ScrollView {
            HStack {
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color(.systemGreen))
                            .cornerRadius(15)
                        Text("1st")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                }
                .shadow(radius: 10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color(.systemGreen))
                            .cornerRadius(15)
                        Text("2nd")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                    
                }
                .shadow(radius: 10)
            }
            .padding(.vertical)
            .padding(.horizontal, 25)
            
            HStack {
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color(.systemGreen))
                            .cornerRadius(15)
                        Text("3rd")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                }
                .shadow(radius: 10)
                
                Spacer()
                
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color(.systemGreen))
                            .cornerRadius(15)
                        Text("4th")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                }
                .shadow(radius: 10)
            }
            .padding(.vertical)
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    MainView()
}
