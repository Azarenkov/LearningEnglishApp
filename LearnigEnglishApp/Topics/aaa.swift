//
//  aaa.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 02.04.2024.
//

import SwiftUI

struct aaa: View {
    
    @State private var isRotationEnabled = true
    @State private var data: [Topic] = []
    
    var body: some View {
        
        NavigationView {
            VStack {
                GeometryReader {
                    let size = $0.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(items) { item in
                                CardView(item)
                                    .padding(.horizontal, 65)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: 5))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMinX(geometryProxy, offset: 10))
                                    }
                                    .zIndex(items.zIndex(item))
                            }
                        }
                        .padding(.vertical, 15)
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(.hidden)
                }
                .frame(height: 420)
            }
        }
    }
    
    @ViewBuilder
    func CardView(_ item: Item) -> some View {
        NavigationLink {
            TopicView()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(item.color.gradient)
                Text("Present Simple")
                    .foregroundStyle(.white)
                    .font(.bold(.title2)())
                    .shadow(radius: 5)
                    .padding()
            }
        }
    }
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress = maxX / width - 1.0
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        
        return progress * offset
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        
        return .init(degrees: progress * rotation)
    }
    
    func fetchTopics() {
        
        let docRef = FirebaseManager.shared.firestore.collection("topics")
            
        docRef.getDocuments { querysnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var newsData: [Topic] = []
                for document in querysnapshot?.documents ?? [] {
                    if let newsItemData = document.data() as? [String: Any] {
                        let id = document.documentID
                        let title = newsItemData["title"] as? String ?? ""
                        let text = newsItemData["title"] as? String ?? ""
                        let russian = newsItemData["title"] as? String ?? ""
                        
                        let newItem = Topic(id: id, title: title, text: text, russian: russian)
                        newsData.append(newItem)
                    }
                }
                self.data = newsData
            }
        }
        
    }
}

#Preview {
    aaa()
}
