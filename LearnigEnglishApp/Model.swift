//
//  User.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import FirebaseFirestoreSwift
import SwiftUI
import FirebaseFirestore
import Firebase


struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var uid, email, nickname: String
}

struct Topic: Identifiable {
    var id: String
    var title: String
    var text: String
    var russian: String
}
struct Privacy: Identifiable, Codable {
    @DocumentID var id: String?
    var text, text2: String
}

struct Results: Identifiable, Codable {
    @DocumentID var id: String?
    var result, tests: Int
    var uid: String
    var timestamp: Date
}

struct TestItem: Identifiable {
    var id: String
    var text: String
    var answer: String
}

struct Test: Identifiable {
    var id: String
    var title: String
}

extension [Topic] {
    func zIndex(_ topic: Topic) -> CGFloat {
        if let index = firstIndex(where: { $0.id == topic.id }) {
            return CGFloat(count) - CGFloat(index)
        }
        return .zero
    }
}
