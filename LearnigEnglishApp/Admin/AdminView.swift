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
                    AdminTestView()
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
        ScrollView {
            Group {
                Text("Заголовок на английском")
                    .font(.headline)
                TextField("Введите заголовок", text: $vm.title)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 4)
                    .padding()
            }
            
            Group {
                Text("Тема для изучения на английском")
                    .font(.headline)
                TextField("Введите тему на английском", text: $vm.text)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 4)
                    .padding()
            }
            
            Group {
                Text("Тема для изучения на русском")
                    .font(.headline)
                TextField("Введите тему на русском", text: $vm.russian)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 4)
                    .padding()
            }
            
            
            Button {
                vm.storeTopicInformation()
            } label: {
                Text("Сохранить")
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
        .alert(isPresented: $vm.showAlert) {
            Alert(
                title: Text("Уведомление"),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                })
            )
        }
        .navigationBarTitle("Тема для изучения")
    }
}

import SwiftUI

struct AdminTestView: View {
    @ObservedObject var viewModel = AdminViewModel()
    @State private var title: String = ""
    @State private var questionText: String = ""
    @State private var answer: String = ""
    @State private var currentTest: String = ""
    @State private var message: String?

    var body: some View {
        ScrollView {
            TextField("Заголовок", text: $title)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding()

            Button("Создать тест") {
                if title.isEmpty {
                    message = "Please enter a test title"
                } else {
                    viewModel.addTest(title: title)
                    currentTest = title
                    title = ""
                    message = "Тест создан"
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()

            Divider().padding(.vertical)

            if !currentTest.isEmpty {
                TextField("Задание", text: $questionText)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 4)
                    .padding()
                
                TextField("Ответ", text: $answer)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .shadow(radius: 4)
                    .padding()

                Button("Сохранить данные в \(currentTest)") {
                    if questionText.isEmpty || answer.isEmpty {
                        message = "Заполните все поля"
                    } else {
                        viewModel.addQuestion(toTest: currentTest, text: questionText, answer: answer)
                        questionText = ""
                        answer = ""
                        message = "Задание сохранено в \(currentTest)!"
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            if let message = message {
                Text(message)
                    .foregroundColor(.red)
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle("Тест")
        .padding()
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}

