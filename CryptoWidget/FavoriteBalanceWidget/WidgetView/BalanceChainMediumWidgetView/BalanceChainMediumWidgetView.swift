//
//  BalanceChainMediumWidgetView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import WidgetKit

struct BalanceChainMediumWidgetView: View {
    @EnvironmentObject var data: WidgetData
    
    var entry: BalanceChainWidgetEntry
    
    var body: some View {
        
        VStack {
            if let name = entry.selectedCoinName,
               let chain = data.findChain(named: name) {
                Link(destination: Deeplink.shared.url(for: chain.code)) {
                    BalanceChainWidgetMediumCardView(vm: ChainViewModel(chain: chain))
                }
            }else {
                Link(destination: Deeplink.shared.url(for: entry.chains[0].code)) {
                    BalanceChainWidgetMediumCardView(vm: ChainViewModel(chain: entry.chains[0]) )
                }
            }
        }
        .padding(.top, 16.0)
        .padding(.horizontal, 0.0)
        .background(BackgroundGradientView())
        .onAppear() {
            print(Deeplink.shared.url(for: "btc"))
        }
    }
}

struct BalanceChainMediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceChainMediumWidgetView(entry: BalanceChainWidgetEntry(
                    date: Date(),
                    chains: Chain.placeholderChainList,
                    configuration: CryptoBalanceChainWidgetConfigurationIntent()))
            .environmentObject(WidgetData())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
