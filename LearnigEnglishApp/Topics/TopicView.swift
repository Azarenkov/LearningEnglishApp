//
//  TopicView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 19.03.2024.
//

import SwiftUI

struct TopicsView: View {
    
    @ObservedObject private var vm = TopicViewModel()
    
    var body: some View {
//        NavigationView {
            ScrollView {
                ForEach(vm.topics, id: \.id) { topic in
                    NavigationLink(destination: TopicDetailView(topic: topic)) {
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.purple, Color.red, Color.yellow, Color.blue, Color.green]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing))
                                    .frame(width: 280, height: 150)
                                    .cornerRadius(15)
                                Text(topic.title)
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
            .onAppear {
                vm.getTopic()
            }
    }
}

struct TopicDetailView: View {
    
    let topic: Topic
    
    var body: some View {
        
        Form {
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
        }
        .navigationTitle(topic.title)
//        .onAppear {
//            vm.getTopic()
//        }
    }
}

//struct TopicView: View {
//    
//    @ObservedObject private var vm = TopicViewModel()
//        
//    var body: some View {
//        Form {
//            if let topic = vm.topic {
//                Section(header: Text("English")) {
//                    Text(topic.text)
//                        .font(.callout)
//                        .padding(8)
//                }
//                
//                Section(header: Text("Russian")) {
//                    Text(topic.russian)
//                        .font(.callout)
//                        .padding(8)
//                }
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            vm.getTopic()
//        }
//    }
//}
//
//struct TopicView2: View {
//    
//    @ObservedObject private var vm = TopicViewModel2()
//        
//    var body: some View {
//        Form {
//            if let topic = vm.topic {
//                Section(header: Text("English")) {
//                    Text(topic.text)
//                        .font(.callout)
//                        .padding(8)
//                }
//                
//                Section(header: Text("Russian")) {
//                    Text(topic.russian)
//                        .font(.callout)
//                        .padding(8)
//                }
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            vm.getTopic()
//        }
//    }
//}



struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView()
    }
}
