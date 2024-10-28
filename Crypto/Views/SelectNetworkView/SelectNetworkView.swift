//
//  PopupView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SelectNetworkView: View {
    @EnvironmentObject var data: CryptoAppData
    @StateObject private var viewModel: NetworkViewModel
    @Binding var showPopup: Bool
    
    init(viewModel: NetworkViewModel, showPopup: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _showPopup = showPopup
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // title
            CustomText(name: data.strings.networks, textColor: Colors.blueWhite, alignment: .center, font: Fonts.mediumFont14)
                .padding(.vertical, 24)
            
            // current network
            if let selectedNetwork = viewModel.selectedNetwork {
                HStack(alignment: .center) {
                    SelectNetworkCardView(networkItem: selectedNetwork)
                    Spacer()
                    Image("checkmark")
                        .foregroundColor(Colors.brown)
                }
                .padding(.bottom, 24)
            }
            
            // other network title
            CustomText(name: data.strings.otherNetworks,
                       textColor: Colors.blue70White70, font: Fonts.boldFont18)
            .padding(.bottom, 20.0)
            .padding(.leading, -4.0)
            
            // other network list
            VStack(spacing: 10) {
                ForEach(viewModel.networkList, id: \.self) { item in
                    SelectNetworkCardView(networkItem: item)
                        .onTapGesture {
                            viewModel.updateSelectedNetwork(to: item)
                            showPopup.toggle()
                        }
                }
            }
        }
        .padding(.horizontal, 28.0)
        .padding(.vertical, 24.0)
        .background(Colors.pureWhiteDarkBlue70)
        .overlay(
            TooltipShape()
                .stroke(Colors.brown25Blue70, lineWidth: 2.0)
        )
        .clipShape(TooltipShape())
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        SelectNetworkView(viewModel: NetworkViewModel(), showPopup: .constant(false))
            .environmentObject(CryptoAppData())
    }
}
