//
//  MultiChainWidgetView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct MultiChainWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: MultiChainWidgetProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemLarge:
            MultiChainLargeWidgetView(entry: entry)
        default:
            Text("More Widgets coming soon...")
        }
    }
}
