//
//  CryptoApp.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct CryptoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject private var themeManager = SystemThemeManager()
    @StateObject private var data = CryptoAppData()
    var body: some Scene {
        WindowGroup {
            SessionView()
                .environmentObject(data)
                .preferredColorScheme(themeManager.selectedTheme)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
}
