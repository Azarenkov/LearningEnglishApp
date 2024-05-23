//
//  extensions.swift
//  LearningEnglishApp
//
//  Created by Алексей Азаренков on 25.05.2024.
//

import Foundation

extension UserDefaults {
    var shouldShowGoogleInfo: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "shouldShowGoogleInfo") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "shouldShowGoogleInfo")
        }
    }
}

extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
}

//extension UserDefaults {
//    var shouldShowMainView: Bool {
//        get {
//            return (UserDefaults.standard.value(forKey: "shouldShowMainView") as? Bool) ?? false
//        }
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: "shouldShowMainView")
//        }
//    }
//}


