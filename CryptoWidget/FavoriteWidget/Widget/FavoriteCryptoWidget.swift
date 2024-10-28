//
//  FavoriteCryptoWidget.swift
//  CryptoWidget
//
//  Created by Virtual Gravity.
//

import WidgetKit
import SwiftUI

struct FavoriteCryptoWidget: Widget {
    let kind: String = "FavoriteCryptoWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
                kind: kind,
                intent: CryptoWidgetConfigurationIntent.self,
                provider: FavoriteWidgetProvider()) { entry in
            
            FavoriteCryptoWidgetView(entry: entry)
                        .environmentObject(WidgetData())
        }
        .configurationDisplayName("Favorite Coin")
        .description("Keep track of your favorite coin")
        .supportedFamilies([
            .systemSmall
        ])
    }
}
