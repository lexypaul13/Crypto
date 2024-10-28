//
//  Provider.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct FavoriteWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> FavoriteWidgetEntry {
        FavoriteWidgetEntry(
                date: Date(),
                chains: Chain.placeholderChainList,
                configuration: CryptoWidgetConfigurationIntent())
    }

    func getSnapshot(for configuration: CryptoWidgetConfigurationIntent, in context: Context, completion: @escaping (FavoriteWidgetEntry) -> ()) {
        let entry = FavoriteWidgetEntry(
                            date: Date(),
                            chains: Chain.snapshotChainList,
                            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: CryptoWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<FavoriteWidgetEntry>) -> ()) {
        var entries: [FavoriteWidgetEntry] = []
        
        let entry = FavoriteWidgetEntry(
                            date: Date(),
                            chains: Chain.snapshotChainList,
                            configuration: configuration)
        entries.append(entry)
        
        // refresh every 5 minutes if possible
        let timeline = Timeline(entries: entries, policy: .after(.now.advanced(by: 60 * 5)))
        
        completion(timeline)
    }
}
