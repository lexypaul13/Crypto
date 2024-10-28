//
//  MultiChainEntry.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct MultiChainEntry: TimelineEntry {
    let date: Date
    let chains: [Chain]
    let configuration: CryptoMultiChainWidgetConfigurationIntent
}

extension MultiChainEntry {
    
    var selectedCoinNames: [String] {
        return [
            configuration.firstCoin,
            configuration.secondCoin,
            configuration.thirdCoin,
            configuration.fourthCoin
        ].compactMap { $0?.displayString }
    }
}
