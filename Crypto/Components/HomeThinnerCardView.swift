//
//  HomeThinnerCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct HomeThinnerCardView: View {
    let vm: ChainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                vm.image
                    .resizable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        CustomText(name: vm.name, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.regularFont16, maxWidth: true)
                        CustomText(name: vm.amount, textColor: Colors.blueWhite, alignment: .trailing, font: Fonts.boldFont16, maxWidth: false)
                    }
                    HStack(spacing: 0) {
                        CustomText(name: vm.dollarPrice, textColor: Colors.blue70White, alignment: .leading, font: Fonts.regularFont14, maxWidth: false)
                            .layoutPriority(1)
                        CustomText(name: vm.changePercent, textColor: vm.changeTint, alignment: .leading, font: Fonts.regularFont14, maxWidth: false)
                            .layoutPriority(2)
                        CustomText(name: vm.code, textColor: Colors.blueWhite, alignment: .trailing, font: Fonts.regularFont12, maxWidth: true)
                    }
                }
                Spacer()
                
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Colors.brown8Brown5)
        .cornerRadius(20)
    }
}

struct HomeThinnerCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeThinnerCardView(vm: ChainViewModel(chain: CryptoAppData.Preview.token))
    }
}
