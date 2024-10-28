//
//  TextWithImage.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TextWithImage: View {
    var todayChangedAmount: String
    var todayChangedPercentage: String
    var textBackgroundColor: Color
    var textForegroundColor: Color
    var font: Font = Fonts.mediumFont14
    var image: Image?
    var imageForegroundColor: Color = Colors.brown
    var verticalPadding: Double = 4
    var cornerRadius: Double = 18
    var body: some View {
        HStack(spacing: 12) {
            HStack(spacing: 2) {
                if let image = image {
                    image
                        .foregroundColor(imageForegroundColor)
                }
                CustomText(name: todayChangedAmount, textColor: textForegroundColor, alignment: .center, font: font, maxWidth: false)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, verticalPadding)
            .background(textBackgroundColor)
            .cornerRadius(cornerRadius)
            if(todayChangedPercentage != "") {
                CustomText(name: todayChangedPercentage, textColor: Colors.green, alignment: .center, font: Fonts.boldFont14, maxWidth: false)
            }
        }
    }
}

struct TextWithImage_Previews: PreviewProvider {
    static var previews: some View {
        TextWithImage(
            todayChangedAmount: "$ 2000",
            todayChangedPercentage: "3.35%",
            textBackgroundColor: Colors.brown8Brown5,
            textForegroundColor: Colors.blueWhite,
            image: Image("send"),
            imageForegroundColor: Colors.blueWhite,
            verticalPadding: 8,
            cornerRadius: 30)
        
    }
}
