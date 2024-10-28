//
//  CustomText.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct CustomText: View {
    var name: String = ""
    var textColor: Color = Colors.blueWhite
    var darkMode: Bool = false
    var alignment: Alignment = .leading
    var padding: CGFloat = 4
    var font: Font = Fonts.regularFont16
    var maxWidth = true
    var setGradient = false
    var lineLimit: Int?
    var multilineTextAlignment: TextAlignment?
    var body: some View {
        Text(name)
            .font(font)
            .frame(alignment: alignment)
            .padding(padding)
            .if(maxWidth) { content in
                content.frame(maxWidth: .infinity, alignment: alignment)
            }
            .if(setGradient) { content in
                content.foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Colors.brown, Colors.brownWhite]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
            .if(!setGradient) { content in
                content.foregroundColor(textColor)
            }
            .if(lineLimit != nil) { content in
                content.lineLimit(lineLimit)
            }
            .if(multilineTextAlignment != nil) { content in
                content.multilineTextAlignment(multilineTextAlignment!)
            }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomText()
    }
}

