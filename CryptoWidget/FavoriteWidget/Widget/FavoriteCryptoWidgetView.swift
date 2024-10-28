//
//  FavoriteCryptoWidgetView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import WidgetKit
import SwiftUI

struct FavoriteCryptoWidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var entry: FavoriteWidgetProvider.Entry

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            FavoriteSmallWidgetView(entry: entry)
        default:
            Text("More Widgets coming soon...")
        }
    }
}
