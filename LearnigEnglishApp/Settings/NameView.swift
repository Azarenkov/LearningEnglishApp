//
//  NameView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 25.05.2024.
//

import SwiftUI

struct NameView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    @State private var nickname = ""

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            
            Spacer()
            
            logo
                .padding(.vertical)
            
            Spacer()
            
            TextField("Name", text: $nickname)
                .autocapitalization(.none)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding()
            
            
            Button {
                vm.updateName(nickname: nickname)
                nickname = ""
            } label: {
                Text("Submit")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(100)
            }
            .shadow(radius: 10)
            .padding()
            
            Spacer()
        }
        .alert(isPresented: $vm.showAlert) {
            Alert(title: Text("Result"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            })
            )
        }
        .navigationTitle("Name Changing")
    }
    
    private var logo: some View {
        
        if colorScheme == .dark {
            Image("Artboard 8")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 100)
                .clipped()
        } else {
            Image("Artboard 7")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 100)
                .clipped()
        }
    }
}
