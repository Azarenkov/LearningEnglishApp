//
//  PrivacyView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 25.05.2024.
//

import SwiftUI

struct PrivacyView: View {
    
    @ObservedObject private var vm = SettingsViewModel()
    
    var body: some View {
        Form {
            if let privacy = vm.privacy {
                Section {
                    Text(privacy.text)
                        .font(.callout)
                        .padding(8)
                }
                
                Section(header: Text("Руководство пользователя")) {
                    Text(privacy.text2)
                        .font(.callout)
                        .padding(8)
                }
            } else {
                ProgressView()
            }
        }
    }
}
