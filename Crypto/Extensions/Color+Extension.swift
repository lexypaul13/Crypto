//
//  UIColor+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import UIKit
import SwiftUI

extension UIColor {
    var color: Color {
        Color(uiColor: self)
    }
}

extension Color {
    var uiColor: UIColor {
        UIColor(self)
    }
}
