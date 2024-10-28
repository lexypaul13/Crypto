//
//  SystemThemeManager.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

class SystemThemeManager: ObservableObject {
    
    @AppStorage("appSystemTheme") private var systemTheme: Int?
    
    var selectedTheme: ColorScheme? {
        guard let systemThemeId = systemTheme,
                let theme = SystemTheme(rawValue: systemThemeId) else { return nil }
        
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
    
    func updateSystemTheme(to theme: SystemTheme) {
        systemTheme = theme.rawValue
    }
    
    func currentSystemTheme() -> SystemTheme? {
        guard let systemThemeId = systemTheme,
              let theme = SystemTheme(rawValue: systemThemeId) else { return .system }
        
        return theme
    }
}
