//
//  UITabBarAppearance+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

extension UITabBarAppearance {
    static func configureTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = Colors.whiteDarkBlue.uiColor
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Colors.brown0Brown.uiColor]
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: Colors.brown0White.uiColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: .bold)]
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = Colors.brown0White.uiColor
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = Colors.brown0Brown.uiColor
        tabBarAppearance.shadowColor = .clear
        tabBarAppearance.shadowImage = UIImage()
        tabBarAppearance.backgroundImage = UIImage()
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
