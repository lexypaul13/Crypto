//
//  SimpleEntry.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct FavoriteWidgetEntry: TimelineEntry {
    let date: Date
    let chains: [Chain]
    let configuration: CryptoWidgetConfigurationIntent
}

extension FavoriteWidgetEntry {
    var selectedCoinName: String? {
        return configuration.favoriteCoin?.displayString
    }
}
