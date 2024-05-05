//
//  TasksView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 02.04.2024.
//

import SwiftUI

struct TestsListView: View {
    @ObservedObject var viewModel = TestsViewModel()
    @State private var currentIndex = 0

    let colors: [Color] = [Color.yellow, Color.red, Color.pink, Color.purple, Color.orange, Color.green, Color.blue]

    var body: some View {
        VStack {
            if viewModel.tests.isEmpty {
                ProgressView()
            } else {
                
                Spacer()
                
                TabView(selection: $currentIndex) {
                    ForEach(Array(viewModel.tests.enumerated()), id: \.element.id) { index, test in
                        CardView(test, color: colors[index % colors.count])
                            .padding(.horizontal, 40)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 420)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .shadow(radius: 10)
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchTestList()
        }
    }

    @ViewBuilder
    func CardView(_ test: Test, color: Color) -> some View {
        NavigationLink(destination: TestDetailView(testId: test.id, viewModel: viewModel)) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .frame(width: 280, height: 350)
                    .cornerRadius(15)

                Text(test.title)
                    .foregroundStyle(.white)
                    .font(.title2.bold())
                    .shadow(radius: 5)
                    .padding()
            }
        }
        .padding(.bottom, 70)
    }
}

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
                userAnswer = "" 
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
