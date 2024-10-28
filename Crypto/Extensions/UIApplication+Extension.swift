//
//  UIApplication + Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import  UIKit

extension UIApplication {

    @discardableResult
    static func openAppSetting() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }

        UIApplication.shared.open(settingsURL)
        return true
    }
    
    /// Dismissed keyboard
    func endEditing(_ force: Bool) {
        UIApplication.shared.customKeyWindow?.endEditing(force)
    }
    
    var windowScene: UIWindowScene? {
        // Get the first UIWindowScene from connected scenes which is active and visible to user
        UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
    
    var customKeyWindow: UIWindow? {
        
        // Get associated windows from the active UIWindowScene
        return UIApplication.shared.windowScene?.windows
            // and keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    var keyWindowPresentedController: UIViewController? {
        var viewController = UIApplication.shared.customKeyWindow?.rootViewController
        
        // If root `UIViewController` is a `UITabBarController`
        if let presentedController = viewController as? UITabBarController {
            // Move to selected `UIViewController`
            viewController = presentedController.selectedViewController
        }
        
        // Go deeper to find the last presented `UIViewController`
        while let presentedController = viewController?.presentedViewController {
            // If root `UIViewController` is a `UITabBarController`
            if let presentedController = presentedController as? UITabBarController {
                // Move to selected `UIViewController`
                viewController = presentedController.selectedViewController
            } else {
                // Otherwise, go deeper
                viewController = presentedController
            }
        }
        
        return viewController
    }
}
