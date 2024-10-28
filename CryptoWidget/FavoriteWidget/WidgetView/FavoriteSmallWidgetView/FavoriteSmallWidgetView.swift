//
//  FavoriteSmallWidgetView.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import SwiftUI
import WidgetKit

struct FavoriteSmallWidgetView: View {
    @EnvironmentObject var data: WidgetData
    
    var entry: FavoriteWidgetEntry
    
    var body: some View {
        
        VStack {
            if let name = entry.selectedCoinName,
               let chain = data.findChain(named: name) {
                FavoriteSmallWidgetCardView(vm: ChainViewModel(chain: chain))
            }else {
                FavoriteSmallWidgetCardView(vm: ChainViewModel(chain: entry.chains[0]) )
            }
            
            Spacer()
        }
        .padding()
        .background(BackgroundGradientView())
        .widgetURL(Deeplink.shared.url(for: data.findChain(named: entry.selectedCoinName ?? "bitcoin")?.code ?? entry.chains[0].code))
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteSmallWidgetView(entry: FavoriteWidgetEntry(
                date: Date(),
                chains: Chain.placeholderChainList,
                configuration: CryptoWidgetConfigurationIntent()))
        .environmentObject(WidgetData())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
