//
//  ClipboardManager.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import SwiftUI

final class ClipboardManager {
    
    static let shared = ClipboardManager()
    
    private init() {}
    
    func copyPlainText(_ text: String) {
        UIPasteboard.general.setValue(text, forPasteboardType: "public.plain-text")
    }
}
