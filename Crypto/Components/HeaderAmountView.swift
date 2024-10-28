//
//  HeaderAmountView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct HeaderAmountView: View {
    @Environment(\.colorScheme) var colorScheme
    var title: String
    var availableBalance: String
    var todayChangedAmount: String
    var body: some View {
        VStack {
            CustomText(name: title, textColor: Colors.blueWhite, alignment: .center, font: Fonts.mediumFont14)
            CustomText(name: availableBalance, textColor: Colors.blueBrown, alignment: .center, font: Fonts.boldFont26, setGradient: colorScheme == .dark)
            if todayChangedAmount != "" {
                TextWithImage(todayChangedAmount: todayChangedAmount, todayChangedPercentage: "+ 2.25%", textBackgroundColor: Colors.brown8LightBrown, textForegroundColor: Colors.brown, image: Image("upArrow"))
            }
            
        }
    }
}

struct HeaderAmountView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderAmountView(title: "Available Balance", availableBalance: "$ 100,000,000", todayChangedAmount: "$5000")
    }
}
