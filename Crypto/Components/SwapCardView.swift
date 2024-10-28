//
//  SwapCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SwapCardView: View {
    var title: String
    var tokenName: String
    var tokenImageStr: String
    @Binding var currentTransactionalTokenAmount: String
    var amountInUSD: String
    var availableTokenAmt: String?
    var curentTransactionalAmountPlaceHolder: String
    var disableUserInteraction: Bool = false
    var symbol: String
    var clicked: (() -> Void)?
    var body: some View {
        VStack(spacing: 20) {
            CustomText(name: title, textColor: Colors.blue70White70, font: Fonts.regularFont12)
            VStack(spacing: 4) {
                HStack {
                    Button {
                        clicked?()
                    } label: {
                        Image(tokenImageStr)
                            .resizable()
                            .frame(width: 24, height: 24)
                        CustomText(name: tokenName, font: Fonts.boldFont16, maxWidth: false)
                        Image("down")
                            .foregroundColor(Colors.blueWhite)
                    }
                    SwapViewTextField(text: $currentTransactionalTokenAmount, placeHolder: curentTransactionalAmountPlaceHolder, alignment: .trailing, disableUserInteraction: disableUserInteraction, symbol: symbol)
                }
                HStack(spacing: 4) {
                    if let availableTokenAmt = availableTokenAmt {
                        Image("lightWhiteWallet")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(Colors.blue70White70)
                        CustomText(name: availableTokenAmt, textColor: Colors.blue70White70, font: Fonts.regularFont12)
                    }
                    CustomText(name: amountInUSD, textColor: Colors.blue70White70, alignment: .trailing, font: Fonts.regularFont12, maxWidth: true)
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 36, trailing: 24))
        .background(Colors.brown8DarkBlue70)
        .cornerRadius(36)
        .overlay(
            RoundedRectangle(cornerRadius: 36)
                .stroke(Colors.brown25Blue, lineWidth: 1)
        )
    }
}

struct SwapCardView_Previews: PreviewProvider {
    static var previews: some View {
        SwapCardView(title: "From", tokenName: "ETH", tokenImageStr: "ethereum", currentTransactionalTokenAmount: .constant("10"), amountInUSD: "$15", curentTransactionalAmountPlaceHolder: "Enter Amount", symbol: "ETH")
    }
}
