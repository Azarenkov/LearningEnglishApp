//
//  AdminView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 04.05.2024.
//

import SwiftUI

struct AdminView: View {
    
    @State var shouldShowLoginView = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                
                NavigationLink {
                    AdminTopicView()
                        .navigationTitle("Тема для изучения")
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemGray5))
                            .frame(width: 280, height: 200)
                            .cornerRadius(15)
                            .shadow(radius: 7)
                        Text("Добавить тему для изучения")
                            .font(.headline)
                            .bold()
                    }
                }
                .padding()
                
                NavigationLink {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemGray5))
                            .frame(width: 280, height: 200)
                            .cornerRadius(15)
                            .shadow(radius: 7)
                        Text("Добавить тест")
                            .font(.headline)
                            .bold()
                    }
                }
                .padding()
                
                Spacer()
                
                Button {
                    shouldShowLoginView.toggle()
                } label: {
                    Text("Выход")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Admin")
            .fullScreenCover(isPresented: $shouldShowLoginView, onDismiss: nil) {
                LoginView()
            }
        }
    }
}

struct AdminTopicView: View {
    
    @ObservedObject var vm = AdminTopicViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Заголовок на английском")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            TextEditor(text: $vm.title)
                .frame(height: 38)
                .border(Color.gray, width: 3)
                .cornerRadius(6)
                .padding()
            
            HStack {
                Text("Тема для изучения на английском")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            TextEditor(text: $vm.text)
                .frame(height: 180)
                .border(Color.gray, width: 3)
                .cornerRadius(6)
                .padding()
            
            HStack {
                Text("Тема для изучения на русском")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            TextEditor(text: $vm.russian)
                .frame(height: 180)
                .border(Color.gray, width: 3)
                .cornerRadius(6)
                .padding()
            
            Button {
                vm.storeTopicInformation()
            } label: {
                Text("Сохранить")
            }
            .buttonStyle(.borderedProminent)
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Уведомление"), message: Text(vm.alertMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }

        
    }
}

#Preview {
    AdminView()
//    AdminTopicView()
}
