//
//  SystemTheme.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

enum SystemTheme: Int, Identifiable, CaseIterable {
    case system
    case dark
    case light
    
    var id: Self {
        self
    }
    
    var title: String {
        switch self {
        case .system:
            return "Device Settings"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
    
    var description: String {
        switch self {
        case .system:
            return "Use device's default mode"
        case .light:
            return "Use light  mode"
        case .dark:
            return "Use dark mode"
        }
    }
}
