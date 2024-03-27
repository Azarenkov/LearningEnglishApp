//
//  User.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import FirebaseFirestoreSwift
import SwiftUI

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var uid, email, nickname: String
}

struct Topic: Identifiable, Codable {
    @DocumentID var id: String?
    var title, text, russian: String
}

struct Tasks: Identifiable, Codable {
    @DocumentID var id: String?
    var text, answer: String
}

struct Privacy: Identifiable, Codable {
    @DocumentID var id: String?
    var text, text2: String
}

struct Results: Identifiable, Codable {
    @DocumentID var id: String?
    var result: Int
}

struct Item: Identifiable {
    var id: UUID = .init()
    var color: Color
}

var items: [Item] = [
    .init(color: .blue),
    .init(color: .red),
    .init(color: .green),
    .init(color: .yellow),
    .init(color: .purple)
]

extension [Item] {
    func zIndex(_ item: Item) -> CGFloat {
        if let index = firstIndex(where: { $0.id == item.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        
        return .zero
    }
}
