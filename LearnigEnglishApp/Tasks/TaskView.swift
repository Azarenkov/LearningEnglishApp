//
//  TaskView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 25.04.2024.
//

import SwiftUI

struct TaskView: View {
    
    @ObservedObject private var vm = TaskViewModel()
    @State private var answer = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Spacer()
        
        Text(vm.currentTask?.text ?? "Nothing")

        
        Spacer()
        
        TextField("Answer", text: $vm.answer)
            .autocapitalization(.none)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        
        Button {
            vm.sumResult()
            vm.getNextTask()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 150, height: 50)
                    .foregroundColor(Color(.systemBlue))
                    .cornerRadius(15)
                Text(">")
                    .foregroundStyle(.white)
                    .font(.headline)
            }
        }
        .shadow(radius: 10)
        
        .actionSheet(isPresented: $vm.showResultOptions) {
            .init(title: Text("Result"), message: Text("Your result is \(vm.result)/\(vm.tasks.count)"), buttons: [
                .destructive(Text("OK"), action: {
                    print("handle sign out")
                    presentationMode.wrappedValue.dismiss()
                })
            ])
        }

    }
}

#Preview {
    TaskView()
}
