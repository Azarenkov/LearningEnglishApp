//
//  User.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    var uid, email, nickname: String
}

struct Topic: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var text: String
    var russian: String
}

struct Privacy: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
}
