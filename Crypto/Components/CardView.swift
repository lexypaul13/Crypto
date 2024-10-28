//
//  CardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct CardView: View {
    let vm: ChainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    CustomText(name: vm.name, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.boldFont18, maxWidth: false)
                    CustomText(name: vm.code, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.regularFont12, maxWidth: false)
                }
                Spacer()
                vm.image
                    .resizable()
                    .frame(width: 38, height: 38)
            }
            Spacer()
                .frame(height: 16)
            HStack(spacing: 2) {
                CustomText(name: vm.dollarPrice, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.boldFont20, maxWidth: true)
                CustomText(name: vm.changePercent, textColor: vm.changeTint, alignment: .trailing, font: Fonts.boldFont16, maxWidth: false)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Colors.brown8Brown5)
        .cornerRadius(20)
        .frame(width: UIScreen.main.bounds.size.width / 1.65)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(vm: ChainViewModel(chain: CryptoAppData.Preview.token))
    }
}
