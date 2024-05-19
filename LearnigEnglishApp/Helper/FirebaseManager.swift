//
//  FirebaseManager.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 28.02.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    
    var currentUser: User?
    
    static let shared = FirebaseManager()
    
    override init() {
        
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        super.init()
        
    }
}
