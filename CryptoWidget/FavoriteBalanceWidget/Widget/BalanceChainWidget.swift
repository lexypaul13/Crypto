//
//  BalanceChainWidget.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import WidgetKit
import SwiftUI

struct BalanceChainCryptoWidget: Widget {
    let kind: String = "BalanceChainCryptoWidget"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(
                kind: kind,
                intent: CryptoBalanceChainWidgetConfigurationIntent.self,
                provider: BalanceChainWidgetProvider()) { entry in
            
            BalanceChainWidgetView(entry: entry)
                        .environmentObject(WidgetData())
        }
        .configurationDisplayName("Your Favorite Coin")
        .description("Keep track of your favorite coin.")
        .supportedFamilies([
            .systemMedium
        ])
    }
}
