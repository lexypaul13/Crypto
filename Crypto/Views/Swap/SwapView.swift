//
//  SwapView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SwapView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var data: CryptoAppData
    private var info: [KeyValueItem] = KeyValueItem.swapInfoList
    @State var sendingTransactionalTokenAmount = ""
    @State var receivingTransactionalTokenAmount = "0"
    @State var showSelectToken: Bool = false
    @State var sendNetwork: AddNetwork =  AddNetwork(id: "fd25a1de-427f-11ee-be56-0242ac120002", name: "Ethereum", imageName: "ethereum", amount: 123456, added: false, code: "ETH", change: -2.9, price: 1912.89)
    @State var receiveNetwork: AddNetwork =  AddNetwork(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", imageName: "bitcoin", amount: 123456, added: true, code: "BTC", change: 5.8, price: 3912.89)
    @State var selectSendNetwork: Bool = true
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack(alignment: .center) {
                        VStack {
                            SwapCardView(title: data.strings.from, tokenName: sendNetwork.code, tokenImageStr: sendNetwork.imageName, currentTransactionalTokenAmount: $sendingTransactionalTokenAmount, amountInUSD:   (sendingTransactionalTokenAmount.fractionNumberDouble * 1.5 ).dollar, availableTokenAmt: sendNetwork.amount.fractionNumber, curentTransactionalAmountPlaceHolder: data.strings.enterAmount, symbol: sendNetwork.code) {
                                selectSendNetwork = true
                                showSelectToken = true
                            }
                            SwapCardView(title: data.strings.receive, tokenName: receiveNetwork.code, tokenImageStr: receiveNetwork.imageName, currentTransactionalTokenAmount: $receivingTransactionalTokenAmount , amountInUSD:  (sendingTransactionalTokenAmount.fractionNumberDouble * 1.5 - 0.002).zeroIfNegative.dollar, curentTransactionalAmountPlaceHolder: "",disableUserInteraction: true, symbol: receiveNetwork.code) {
                                selectSendNetwork = false
                                showSelectToken = true
                            }
                        }
                        Image("reverse")
                    }
                    Spacer().frame(height: 32)
                    ForEach(Array(info.enumerated()), id: \.0) { (index, item) in
                        VStack(spacing: 16) {
                            HStack {
                                CustomText(name: item.key, textColor: Colors.blue70White70, font: Fonts.regularFont14)
                                CustomText(name: item.key == data.strings.exchangeRate ? "1\(sendNetwork.code) = 1.5\(receiveNetwork.code)" : item.value, alignment: .trailing, font: Fonts.regularFont14, maxWidth: true)
                            }
                            if index != (info.count - 1) {
                                CustomDivider(height: 1)
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .onTapGesture {
                // Dismiss the keyboard when tapping outside the text field
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            PrimaryButton(text: data.strings.swapNow, clicked: {})
        }
        .padding(24)
        .navigationBarBackButtonHidden()
        .background(
            BackgroundGradientView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 0) {
                    ToolbarContentView(title: data.strings.swapToken, subTitle: "FANTOM OPERA")
                }
            }
        }
        .onChange(of: sendingTransactionalTokenAmount) { newText in
            updateReceivingTransactionalTokenAmount()
        }
        .background(NavigationLink("", destination: AddNetworkView(viewModel: data.addNetworkViewModel, sectionName: data.strings.assets) { addNetwork in
            switch selectSendNetwork {
            case true: sendNetwork = addNetwork
            case false: receiveNetwork = addNetwork
            }
        }, isActive: $showSelectToken).hidden())
    }
    
    private func updateReceivingTransactionalTokenAmount() {
        receivingTransactionalTokenAmount  = (sendingTransactionalTokenAmount.fractionNumberDouble * 0.4).fractionNumber
    }
}

struct SwapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwapView()
                .environmentObject(CryptoAppData())
        }
        .previewDisplayName("Light")
        .preferredColorScheme(.light)
        
        NavigationView {
            SwapView()
                .environmentObject(CryptoAppData())
        }
        .previewDisplayName("Dark")
        .preferredColorScheme(.dark)
    }
}

extension KeyValueItem {
    static var swapInfoList: [KeyValueItem] {
        [
            KeyValueItem(key: "Exchange Rate", value: "1ETH = ≈0.064BTC"),
            KeyValueItem(key: "Slippage Tolerance", value: "1.5% >"),
            KeyValueItem(key: "Est. Network Fee", value: "$1.23")
        ]
    }
}
