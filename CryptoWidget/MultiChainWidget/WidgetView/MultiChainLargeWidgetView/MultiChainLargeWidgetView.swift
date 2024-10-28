//
//  MultiChainLargeWidgetView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import WidgetKit

struct MultiChainLargeWidgetView: View {
    @EnvironmentObject var data: WidgetData
    
    var entry: MultiChainEntry
    
    var body: some View {
        VStack(spacing: 16.0) {
            
            if entry.selectedCoinNames.isEmpty {
                
                ForEach(entry.chains.suffix(4).map{ ChainViewModel(chain: $0)}) { item in
                    Link(destination: Deeplink.shared.url(for: item.code)) {
                        MultiChainLargeWidgetCardView(vm: item)
                    }
                }
            }else {
                ForEach(data.findChains(in: entry.selectedCoinNames).map{ ChainViewModel(chain: $0)}) { item in
                    Link(destination: Deeplink.shared.url(for: item.code)) {
                        MultiChainLargeWidgetCardView(vm: item)
                    }
                }
            }
        }
        .padding()
        .background(BackgroundGradientView())
    }
}

struct MultiChainLargeWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MultiChainLargeWidgetView(
            entry: MultiChainEntry(
                        date: Date(),
                        chains: Chain.snapshotChainList,
                        configuration: CryptoMultiChainWidgetConfigurationIntent())
        )
        .environmentObject(WidgetData())
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
