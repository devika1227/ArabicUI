//
//  LocalizedBundleManager.swift
//  ArabicUI
//
//  Created by Devika on 07/11/2026.
//

import UIKit

class LocalizedBundleManager: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        // Retrieve your stored language code (e.g., "ar" or "en")
        let userLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
        
        if let path = Bundle.main.path(forResource: userLanguage, ofType: "lproj"),
           let localizedBundle = Bundle(path: path) {
            return localizedBundle.localizedString(forKey: key, value: value, table: tableName)
        }
        return super.localizedString(forKey: key, value: value, table: tableName)
    }
}
