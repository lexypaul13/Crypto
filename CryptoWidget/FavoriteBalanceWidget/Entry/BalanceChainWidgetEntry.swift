//
//  BalanceChainWidgetEntry.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct BalanceChainWidgetEntry: TimelineEntry {
    let date: Date
    let chains: [Chain]
    let configuration: CryptoBalanceChainWidgetConfigurationIntent
}

extension BalanceChainWidgetEntry {
        
    var selectedCoinName: String? {
        return configuration.favoriteCoin?.displayString
    }
}
