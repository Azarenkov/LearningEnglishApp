//
//  TopicView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 19.03.2024.
//

import SwiftUI

struct TopicsView: View {
    
    @ObservedObject private var vm = TopicViewModel()
    @ObservedObject private var vm2 = TopicViewModel2()
    
    var body: some View {
//        NavigationView {
            ScrollView {
                
                NavigationLink {
                    TopicView()
                        .navigationTitle(vm.topic?.title ?? "Nothing")
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 280, height: 150)
                            .foregroundColor(Color(.systemCyan))
                            .cornerRadius(15)
                        Text("1st")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                }
                .padding()
                .shadow(radius: 10)
                
                
                NavigationLink {
                    TopicView2()
                        .navigationTitle(vm2.topic?.title ?? "Nothing")
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(width: 280, height: 150)
                            .foregroundColor(Color(.systemCyan))
                            .cornerRadius(15)
                        Text("2nd")
                            .foregroundStyle(.white)
                            .font(.system(size: 55, weight: .thin, design: .rounded))
                    }
                }
                .padding()
                .shadow(radius: 10)
                
            }
//        }
    }
}

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
