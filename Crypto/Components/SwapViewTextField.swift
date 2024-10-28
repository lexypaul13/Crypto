//
//  SwapViewTextField.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SwapViewTextField: View {
    @Binding var text: String
    var placeHolder: String
    var clicked: (() -> Void)?
    var alignment: TextAlignment = .leading
    var disableUserInteraction: Bool = false
    var symbol: String
    var body: some View {
        HStack(spacing: 2) {
            TextField("", text: $text, onEditingChanged: { onEditChange in
                clicked?()
                if onEditChange { text = "" }
                if text == "" &&  !onEditChange{
                    text = placeHolder
                }
            })
            .keyboardType(.numberPad)
            .disabled(disableUserInteraction)
            .multilineTextAlignment(alignment)
            .foregroundColor(Colors.blueWhite)
            .font(Fonts.boldFont16)
            .accentColor(Colors.brown)
            .placeholder(when: text.isEmpty) {
                CustomText(name: placeHolder, textColor: Colors.blue70White70, alignment: (alignment == .leading) ? Alignment.leading : Alignment.trailing, font: Fonts.boldFont16)
            }
            if text != "" {
                CustomText(name: symbol, font: Fonts.boldFont16, maxWidth: false)
            }
        }
    }
}
