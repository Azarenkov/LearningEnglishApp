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
    
    @State private var views = [0, 1, 2]

    
    var body: some View {
        NavigationStack {
            TabView {
                TopicsView()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Topics")
                    }
                
                TasksView()
                    .tabItem {
                        Image(systemName: "pencil.and.list.clipboard")
                        Text("Tasks")
                    }
                
                SettingsView(shouldShowLogOutOptions: $shouldShowLogOutOptions)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            

            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                    .destructive(Text("Sign out"), action: {
                        print("handle sign out")
                        vm.handleSignOut()
                    }),
                    .cancel()
                ])
            }
            
            .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut) {
                LoginView(
//                    didCompleteLoginProcess: {
//                    self.vm.isUserCurrentlyLoggedOut = false
//                    self.vm.fetchCurrentUser()
//                }
                )
            }
        }
    }
}

struct TopicsView: View {
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                HStack {
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color(.systemCyan))
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
                                .foregroundColor(Color(.systemCyan))
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
                                .foregroundColor(Color(.systemCyan))
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
                                .foregroundColor(Color(.systemCyan))
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
            .navigationTitle("Topics")
        }
    }
}

struct TasksView: View {
    
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Tasks")
        }
    }
}

struct SettingsView: View {
    
    @ObservedObject private var vm = MainViewModel()
    
    @Binding var shouldShowLogOutOptions: Bool

    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Information")) {
                    NavigationLink {
                        
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
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    MainView()
}
