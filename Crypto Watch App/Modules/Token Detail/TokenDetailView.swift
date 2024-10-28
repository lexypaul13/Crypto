//
//  TokenDetailView.swift
//  Crypto Watch App
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TokenDetailView: View {
    var tokenName: String
    var percentage: Double
    var currentValue: String
    var body: some View {
        let randomDataPoints = (0..<30).map { _ in CGFloat.random(in: -10...15) }
        ScrollView {
            VStack {
                HStack {
                    CustomText(name: tokenName, textColor: Colors.whiteDarkBlue, font: Fonts.boldFont16)
                    CustomText(name: "\(percentage)%", textColor: Colors.whiteDarkBlue, alignment: .trailing, font: Fonts.mediumFont16)
                }
                CustomText(name: currentValue, textColor: percentage > 0 ? Colors.green : Colors.red, alignment: .center, font: Fonts.boldFont26)
                LineGraphView(dataPoints: randomDataPoints, graphForegroundColor: percentage > 0 ? Colors.green : Colors.red, maxValue: 15)
            }
        }
    }
}

struct TokenDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TokenDetailView(tokenName: "Bake/USD", percentage: 0.38, currentValue: "0.079")
    }
}
