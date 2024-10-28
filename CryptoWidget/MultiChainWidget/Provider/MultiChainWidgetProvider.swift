//
//  MultiChainWidgetProvider.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import WidgetKit

struct MultiChainWidgetProvider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> MultiChainEntry {
        MultiChainEntry(
                date: Date(),
                chains: Chain.snapshotChainList,
                configuration: CryptoMultiChainWidgetConfigurationIntent())
    }

    func getSnapshot(for configuration: CryptoMultiChainWidgetConfigurationIntent, in context: Context, completion: @escaping (MultiChainEntry) -> ()) {
        let entry = MultiChainEntry(
                            date: Date(),
                            chains: Chain.snapshotChainList,
                            configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: CryptoMultiChainWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<MultiChainEntry>) -> ()) {
        var entries: [MultiChainEntry] = []
        
        
        let entry = MultiChainEntry(
                        date: Date(),
                        chains: Chain.snapshotChainList,
                        configuration: configuration)
        entries.append(entry)
        
        // refresh every 5 minutes if possible
        let timeline = Timeline(entries: entries, policy: .after(.now.advanced(by: 60 * 5)))
        
        completion(timeline)
    }
}
