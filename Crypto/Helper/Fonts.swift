//
//  Fonts.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import UIKit
import SwiftUI

struct Fonts {
    static let regularFont10  = "regularFont10".font
    static let regularFont12  = "regularFont12".font
    static let regularFont14  = "regularFont14".font
    static let regularFont16  = "regularFont16".font
    
    static let mediumFont10   = "mediumFont10".font
    static let mediumFont12   = "mediumFont12".font
    static let mediumFont14   = "mediumFont14".font
    static let mediumFont16   = "mediumFont16".font
    static let mediumFont20   = "mediumFont20".font
    
    static let semiBoldFont14 = "semiBoldFont14".font
    static let semiBoldFont16 = "semiBoldFont16".font
    
    static let boldFont10     = "boldFont10".font
    static let boldFont12     = "boldFont12".font
    static let boldFont14     = "boldFont14".font
    static let boldFont16     = "boldFont16".font
    static let boldFont18     = "boldFont18".font
    static let boldFont20     = "boldFont20".font
    static let boldFont22     = "boldFont22".font
    static let boldFont24     = "boldFont24".font
    static let boldFont26     = "boldFont26".font
}

extension String {
    
    var font: Font {
        let fontSize: CGFloat = self.removeAlphabets.toCGFLoat
        var font: Font?
        switch self {
        case self where self.contains("regular") : font = UIFont(name: "Lexend-Regular", size: fontSize)?.font
        case self where self.contains("medium")  : font = UIFont(name : "Lexend-Medium", size : fontSize)?.font
        case self where self.contains("semiBold"): font = UIFont(name : "Lexend-SemiBold", size : fontSize)?.font
        case self where self.contains("bold")    : font = UIFont(name : "Lexend-Bold", size : fontSize)?.font
        default:                                   font = UIFont(name: "Lexend-Regular", size: fontSize)?.font
        }
        return font ?? self.systemFont
    }
    
    var systemFont: Font {
        let fontSize: CGFloat = self.removeAlphabets.toCGFLoat
        switch self {
        case self where self.contains("regular") : return Font.system(size: fontSize, weight: .regular)
        case self where self.contains("medium")  : return Font.system(size: fontSize, weight: .medium)
        case self where self.contains("semiBold"): return Font.system(size: fontSize, weight: .medium)
        case self where self.contains("bold")    : return Font.system(size: fontSize, weight: .bold)
        default: return Font.system(size: 16, weight: .regular)
        }
    }
    
    var removeAlphabets: String {
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z]", options: [])
        let range = NSRange(location: 0, length: self.utf16.count)
        let modifiedString = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return modifiedString
    }
}
