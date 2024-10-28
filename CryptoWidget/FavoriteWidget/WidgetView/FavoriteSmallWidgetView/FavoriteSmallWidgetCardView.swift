//
//  FavoriteSmallWidgetCardView.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct FavoriteSmallWidgetCardView: View {
    
    var vm: ChainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                CustomText(name: vm.code, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.regularFont16, maxWidth: true)
                vm.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 8.0)
            }
            CustomText(name: vm.dollarPrice, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.regularFont14, maxWidth: true)
            CustomText(name: vm.changePercent, textColor: vm.changeTint, alignment: .leading, font: Fonts.mediumFont14, maxWidth: false)
            GraphView()
                .padding(.vertical, 4.0)
            
        }
    }
}
