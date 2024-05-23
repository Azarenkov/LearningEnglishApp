//
//  WelcomeView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 17.05.2024.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("welcomeScreenShown")
    var welcomeScreenShown = false
    
    @State var shouldShowLoginView = false

    var body: some View {
        
        ZStack {
            
            linear
            
            VStack {
                
                Spacer()
                
                logo
                
                Text("Welcome to your journey to mastering English starts here!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top, 25)
                
                Spacer()
                
                Button {
                    UserDefaults.standard.welcomeScreenShown = true
                    shouldShowLoginView.toggle()
                } label: {
                    Text("Start Learning")
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
            }
            .fullScreenCover(isPresented: $shouldShowLoginView, onDismiss: nil) {
                LoginView()
            }

        }
    }

    private var logo: some View {
        if colorScheme == .dark {
            return Image("Artboard 8")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 138)
                .clipped()
        } else {
            return Image("Artboard 7")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 138)
                .clipped()
        }
    }
    
    private var linear: some View {
        if colorScheme == .dark {
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        } else {
            return LinearGradient(gradient: Gradient(colors: [Color.white, Color.cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

