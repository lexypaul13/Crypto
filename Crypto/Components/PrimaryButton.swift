//
//  Button.swift
//
//  Created by Virtual Gravity
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var cornerRadius = CGFloat(12)
    var font: Font = Fonts.boldFont16
    var foregroundColor: Color = Colors.blue
    var backgroundColor: Color = Colors.brown
    var borderWidth: CGFloat?
    var maxHeight: CGFloat = 46
    var clicked: (() -> Void) /// use closure for callback
    var setGradient = true
    var body: some View {
        VStack {
            Button(action: clicked) {
                PrimaryButtonText(
                    text: text,
                    cornerRadius: cornerRadius,
                    font: font,
                    foregroundColor: foregroundColor,
                    backgroundColor: backgroundColor,
                    borderWidth: borderWidth,
                    maxHeight: maxHeight,
                    setGradient: setGradient)
            }
        }
    }
}


struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Button", clicked: {})
    }
}
