//
//  BalanceChainWidgetProvider.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct BalanceChainWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> BalanceChainWidgetEntry {
        BalanceChainWidgetEntry(
                date: Date(),
                chains: Chain.placeholderChainList,
                configuration: CryptoBalanceChainWidgetConfigurationIntent())
    }

    func getSnapshot(for configuration: CryptoBalanceChainWidgetConfigurationIntent, in context: Context, completion: @escaping (BalanceChainWidgetEntry) -> ()) {
        let entry = BalanceChainWidgetEntry(
                        date: Date(),
                        chains: Chain.snapshotChainList,
                        configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: CryptoBalanceChainWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<BalanceChainWidgetEntry>) -> ()) {
        var entries: [BalanceChainWidgetEntry] = []
        
        
        let entry = BalanceChainWidgetEntry(
                        date: Date(),
                        chains: Chain.snapshotChainList,
                        configuration: configuration)
        
        entries.append(entry)
        
        // refresh every 5 minutes if possible
        let timeline = Timeline(entries: entries, policy: .after(.now.advanced(by: 60 * 5)))
        completion(timeline)
    }
}
