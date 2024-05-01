//
//  TasksView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 02.04.2024.
//

import SwiftUI

struct TestsListView: View {
    @ObservedObject var viewModel = TestsViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.tests) { test in
                NavigationLink(destination: TestDetailView(testId: test.id, viewModel: viewModel)) {
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.purple, Color.red, Color.yellow, Color.blue, Color.green]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
                                .frame(width: 280, height: 150)
                                .cornerRadius(15)
                            Text(test.title)
                                .foregroundStyle(.white)
                                .font(.system(size: 20, weight: .light, design: .monospaced))
                                .frame(width: 150)
                        }
                    }
                    .padding()
                    .shadow(radius: 10)
                }
            }
        }
    }
}

// Представление для отображения деталей теста и ответов
struct TestDetailView: View {
    var testId: String
    @ObservedObject var viewModel: TestsViewModel
    @State private var userAnswer: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            
            Spacer()
            
            Text(viewModel.currentTestItem?.text ?? "Loading question...")
                .padding()
            
            Spacer()

            TextField("Answer", text: $userAnswer)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding()

            Button(action: {
                viewModel.checkAnswer(userAnswer: userAnswer)
                userAnswer = "" // Сбросить поле ответа после проверки
            }) {
                Text(">")
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Circle())
            }
            .padding()
            .shadow(radius: 10)
        }
        .alert(isPresented: $viewModel.showResult) {
            Alert(title: Text("Result"), message: Text("Your result is \(viewModel.result)/\(viewModel.testItems.count)"), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
        .navigationBarTitle("Test", displayMode: .inline)
        .padding()
        .onAppear {
            viewModel.loadQuestions(testId: testId)
        }
    }
}


struct TestsListView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
