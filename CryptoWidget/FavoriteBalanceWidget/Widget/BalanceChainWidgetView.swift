//
//  BalanceChainWidgetView.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct BalanceChainWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: BalanceChainWidgetProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemMedium:
            BalanceChainMediumWidgetView(entry: entry)
        default:
            Text("More Widgets coming soon...")
        }
    }
}
