//
//  ScrollViewPadding.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ScrollViewTopPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 1.0)
    }
}

extension View {
    func scrollViewTransparentNavigation() -> some View {
        self.modifier(ScrollViewTopPadding())
    }
}
