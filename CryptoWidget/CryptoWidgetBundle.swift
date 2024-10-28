//
//  CryptoWidgetBundle.swift
//  CryptoWidget
//
//  Created by Virtual Gravity.
//

import WidgetKit
import SwiftUI

@main
struct CryptoWidgetBundle: WidgetBundle {
    var body: some Widget {
        FavoriteCryptoWidget()
        BalanceChainCryptoWidget()
        MultiChainCryptoWidget()
    }
}
