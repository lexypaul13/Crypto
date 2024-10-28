//
//  MultiChainCryptoWidget.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import WidgetKit
import SwiftUI

struct MultiChainCryptoWidget: Widget {
    let kind: String = "MultiChainCryptoWidget"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(
                kind: kind,
                intent: CryptoMultiChainWidgetConfigurationIntent.self,
                provider: MultiChainWidgetProvider()) { entry in
            
            MultiChainWidgetView(entry: entry)
                        .environmentObject(WidgetData())
        }
        .configurationDisplayName("Your Favourite Crypto coins")
        .description("Select your favorite crypto coins.")
        .supportedFamilies([
            .systemLarge
        ])
    }
}


