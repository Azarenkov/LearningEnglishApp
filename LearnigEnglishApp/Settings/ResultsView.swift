//
//  ResultsView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 01.05.2024.
//

import SwiftUI

struct ResultsView: View {
    
    @ObservedObject private var vm = ResultsViewModel()
    
    var body: some View {
        
        
        Form {
            Section {
                HStack() {
                    if let averageScore = vm.averageScore {
                        VStack {
                            RingChart(percentage: averageScore * 100)
                                .padding()
                            Text("Correct answers")
                        }
                    } else {
                        Text("Loading...")
                    }
                    Spacer()
                    
                    VStack {
                        ZStack {
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.blue, Color.red]),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading
                                    ),
                                    style: StrokeStyle(lineWidth: 20)
                                )
                                .frame(width: 100, height: 100)
                            Text("\(vm.results.count)")
                                .font(.title)
                                .bold()
                        }
                        .padding()
                        Text("Passed tests")
                            
                    }
                    
                }
            }
            
            Section(header: Text("Your last results")) {
                if vm.results.isEmpty {
                    Text("You don't have any results")
                } else {
                    ForEach(vm.results) { result in
                        HStack {
                            Text("\(result.result)/\(result.tests)")
                            Spacer()
                            Text("\(result.timestamp.formatted(date: .numeric, time: .shortened))")
                        }
                    }
                }
            }
        }
        .onAppear {
            vm.getResult()
        }
    }
}

#Preview {
    ResultsView()
}
