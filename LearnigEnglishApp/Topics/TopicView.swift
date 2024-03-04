//
//  TopicView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 19.03.2024.
//

import SwiftUI

struct TopicView: View {
    
    @ObservedObject private var vm = TopicViewModel()
        
    var body: some View {
        Form {
            if let topic = vm.topic {
                Section(header: Text("English")) {
                    Text(topic.text)
                        .font(.callout)
                        .padding(8)
                }
                
                Section(header: Text("Russian")) {
                    Text(topic.russian)
                        .font(.callout)
                        .padding(8)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            vm.getTopic()
        }
    }
}

struct TopicView2: View {
    
    @ObservedObject private var vm = TopicViewModel2()
        
    var body: some View {
        Form {
            if let topic = vm.topic {
                Section(header: Text("English")) {
                    Text(topic.text)
                        .font(.callout)
                        .padding(8)
                }
                
                Section(header: Text("Russian")) {
                    Text(topic.russian)
                        .font(.callout)
                        .padding(8)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            vm.getTopic()
        }
    }
}



struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView()
    }
}
