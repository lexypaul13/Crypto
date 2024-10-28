//
//  SelectNetworkCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SelectNetworkCardView: View{
    let networkItem: ChainNetwork
    
    var body: some View {
        HStack (alignment: .center, spacing: 12.0) {
            networkItem.iconImage
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            CustomText(name: networkItem.name, textColor: Colors.blueWhite,
                       font: Fonts.mediumFont14)
        }
    }
}

struct SelectNetworkCardView_Previews: PreviewProvider {
    static var previews: some View {
        SelectNetworkCardView(networkItem: CryptoAppData.Preview.network)
    }
}
