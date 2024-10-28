//
//  TransactionCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TransactionCardView: View {
    let vm: TransactionItemViewModel
    var actionButtonText: String?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                vm.iconImage
                    .resizable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        CustomText(name: vm.title, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.semiBoldFont14, maxWidth: true)
                        if actionButtonText == nil {
                            CustomText(name: vm.transactionAmount, textColor: vm.transactionAmountTintColor, alignment: .trailing, font: Fonts.semiBoldFont14, maxWidth: false)
                        }
                    }
                    HStack(spacing: 0) {
                        CustomText(name: vm.subtitle, textColor: Colors.blueWhite.opacity(0.7), alignment: .leading, font: Fonts.regularFont14, maxWidth: false)
                        if actionButtonText == nil {
                            CustomText(name: vm.date, textColor: Colors.blueWhite.opacity(0.7), alignment: .trailing, font: Fonts.regularFont14, maxWidth: true)
                        }
                    }
                }
                if let actionButtonText = actionButtonText {
                    CustomText(name: actionButtonText, alignment: .trailing, font: Fonts.mediumFont14)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Colors.brown8Brown5)
        .cornerRadius(20)
    }
}

struct TransactionCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCardView(vm: TransactionItemViewModel(transaction: CryptoAppData.Preview.transaction))
    }
}
