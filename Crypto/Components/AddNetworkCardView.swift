//
//  AddNetworkThinnerCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct AddNetworkCardView: View {
    let vm: AddNetwork
    let action: () -> Void
    var isAddNetwork: Bool = true
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                vm.iconImage
                    .resizable()
                    .frame(width: 36, height: 36)
                VStack(alignment: .leading, spacing: 0) {
                    
                    CustomText(name: vm.name, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.boldFont14, maxWidth: false)
                    
                    CustomText(name: vm.displayAmount, textColor: Colors.blueWhite.opacity(0.7), alignment: .leading, font: Fonts.regularFont14, maxWidth: false)
                }
                if isAddNetwork {
                    CustomText(name: vm.actionType.rawValue, textColor: vm.actionTintColor, alignment: .trailing, font: Fonts.mediumFont14)
                        .onTapGesture {
                            action()
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Colors.brown8Brown5)
        .cornerRadius(20)
    }
}

struct AddNetworkCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddNetworkCardView(vm: CryptoAppData.Preview.addNetwork, action: {})
    }
}
