//
//  TopicView.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 19.03.2024.
//

import SwiftUI

struct TopicsView: View {
    @ObservedObject private var vm = TopicViewModel()
    @State private var currentIndex = 0

    let colors: [Color] = [Color.blue, Color.green, Color.orange, Color.purple, Color.pink, Color.red, Color.yellow]

    var body: some View {
        VStack {
            VStack {
                if vm.topics.isEmpty {
                    ProgressView()
                } else {
                    
                    Spacer()
                    
                    TabView(selection: $currentIndex) {
                        ForEach(Array(vm.topics.enumerated()), id: \.element.id) { index, topic in
                            CardView(topic, color: colors[index % colors.count])
                                .padding(.horizontal, 40)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 420)
                    
                    Spacer()

                    ProgressView(value: Double(currentIndex + 1), total: Double(vm.topics.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.horizontal, 100)
                    
                    Spacer()
                }
            }
            .onAppear {
                vm.getTopics()
            }
        }
    }

    @ViewBuilder
    func CardView(_ topic: Topic, color: Color) -> some View {
        NavigationLink(destination: TopicDetailView(topic: topic)) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .shadow(radius: 10)
                Text(topic.title)
                    .foregroundStyle(.white)
                    .font(.title2.bold())
                    .shadow(radius: 5)
                    .padding()
            }
            .frame(width: 280, height: 350)
            .cornerRadius(15)
            .shadow(radius: 10)
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
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView()
    }
}
