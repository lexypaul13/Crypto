//
//  BalanceChainWidgetMediumCardView.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct BalanceChainWidgetMediumCardView: View {
    
    var vm: ChainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                vm.image
                    .resizable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        CustomText(name: vm.name, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.mediumFont14, maxWidth: false)
                        Spacer()
                        CustomText(name: vm.dollarPrice, textColor: Colors.blueWhite, alignment: .trailing, font: Fonts.regularFont14, maxWidth: false)
                    }
                    HStack(spacing: 0) {
                        CustomText(name: vm.code, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.mediumFont12, maxWidth: true)
                            .layoutPriority(1)
                        Spacer()
                        CustomText(name: vm.changePercent, textColor: vm.changeTint, alignment: .trailing, font: Fonts.mediumFont14, maxWidth: false)
                            .layoutPriority(2)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            
            GraphView()
        }
        .padding(.vertical, 8.0)
        .cornerRadius(20)
    }
}
