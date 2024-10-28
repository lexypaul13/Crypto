//
//  SystemLanguage.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

enum SystemLanguage: Int, Identifiable, CaseIterable {
    case system
    case english
    case chinese
    case finnish
    case hindi
    case spanish
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .system:
            return "Device Settings"
        case .english:
            return "English"
        case .chinese:
            return "Chinese Simplified"
        case .finnish:
            return "Finnish"
        case .hindi:
            return "Hindi"
        case .spanish:
            return "Spanish"
        }
    }
    
    var localizedTitle: String {
        let strings = LocalizableString()
        
        switch self {
        case .system:
            return strings.langDeviceSettings
        case .english:
            return strings.langEnglish
        case .chinese:
            return strings.langChineseSimplified
        case .finnish:
            return strings.langFinnish
        case .hindi:
            return strings.langHindi
        case .spanish:
            return strings.langSpanish
        }
    }
    
    var lang: String? {
        switch self {
        case .system:
            return nil
        case .english:
            return "en"
        case .chinese:
            return "zh-Hans"
        case .finnish:
            return "fi"
        case .hindi:
            return "hi"
        case .spanish:
            return "es"
        }
    }
}
