//
//  GlobalFunctions.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct GlobalFunctions {
    
    static func scale(for geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        let maxScale: CGFloat = 1.5
        let scale = 1 + (offset / 500) // Adjust the divisor for the desired zoom intensity
        return min(scale, maxScale)
    }

    static func offset(for geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        return offset > 0 ? -offset : 0
    }
    
    func getNavigationBarHeight() -> CGFloat {
                var statusBarHeight: CGFloat = 0
                
                if #available(iOS 13.0, *) {
                    let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
                    statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                } else {
                    statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                }
                
                let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
                return statusBarHeight + safeAreaInsets
    }
    
}
