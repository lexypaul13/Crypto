//
//  TabBarView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var selectedTab: TabViewItemType
    
    var body: some View {
        HStack {
            Spacer()
            TabViewItem(type: .home, selectedTab: selectedTab, title: data.strings.tabHome) { selectedTab = .home}
            Spacer()
            TabViewItem(type: .wallet, selectedTab: selectedTab, title: data.strings.tabWallet)  { selectedTab = .wallet}
            Spacer()
            TabViewItem(type: .market, selectedTab: selectedTab, title: data.strings.tabMarket)  { selectedTab = .market}
            Spacer()
            TabViewItem(type: .settings, selectedTab: selectedTab, title: data.strings.tabSetting)  { selectedTab = .settings}
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(.home))
            .environmentObject(CryptoAppData())
    }
}
