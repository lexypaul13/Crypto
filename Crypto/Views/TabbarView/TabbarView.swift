//
//
//  Created by Virtual Gravity
//

import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var data: CryptoAppData
    
    init() { // no use
        UITabBarAppearance.configureTabBar()
        UINavigationBarAppearance.configureNavigationBar()
    }
    
    var body: some View {
        return ZStack(alignment: .bottom) {
            tabView()
            Rectangle()
                // Adjust the height as needed for the corner radius
                .frame(height: 78)
                .edgesIgnoringSafeArea(.bottom)
                // Set the color for the rounded part
                .foregroundColor(Colors.brown8DarkBlue)
                .cornerRadius(24)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Colors.brown25Blue, lineWidth: 1)
                        .padding(.top, -4)
                        // removed stoke by increading the paddint of bottom
                        .padding(.bottom, -4)
                )
            TabBarView(selectedTab: $data.selectedTab)
                .frame(height: 78)
                .padding(.vertical, 8)
        } .edgesIgnoringSafeArea(.bottom)
            .onOpenURL { url in
                guard let code = Deeplink.shared.getCode(from: url) else{
                    return
                }
                data.selectedTab = .home
                data.setSelectedChainCode(code)
            }
    }
    
    @ViewBuilder
    private func tabView() -> some View {
        TabView(selection: $data.selectedTab) {
            HomeView()
                .navigationViewStyle(.stack)
                .tabItem { TabViewItem(type: .home, selectedTab: data.selectedTab, title: data.strings.tabHome) }
                .onAppear() { data.selectedTab = .home }
                .tag(TabViewItemType.home)
            WalletView()
                .navigationViewStyle(.stack)
                .tabItem { TabViewItem(type: .wallet, selectedTab: data.selectedTab, title: data.strings.tabWallet) }
                .onAppear() { data.selectedTab = .wallet }
                .tag(TabViewItemType.wallet)
            MarketView()
                .navigationViewStyle(.stack)
                .tabItem { TabViewItem(type: .market, selectedTab: data.selectedTab, title: data.strings.tabMarket) }
                .onAppear() { data.selectedTab = .market }
                .tag(TabViewItemType.market)
            SettingView()
                .navigationViewStyle(.stack)
                .tabItem { TabViewItem(type: .settings, selectedTab: data.selectedTab, title: data.strings.tabSetting) }
                .onAppear() { data.selectedTab = .settings }
                .tag(TabViewItemType.settings)
        }
        .font(.headline)
        .navigationBarTitle(data.selectedTab.navigationTitle, displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabbarView()
                .preferredColorScheme(.light)
                .previewDisplayName("Light Mode")
                .environmentObject(CryptoAppData())
            
            TabbarView()
                .environmentObject(CryptoAppData())
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
            
            TabbarView()
                .environmentObject(CryptoAppData())
                .previewDisplayName("Default Mode")
                .preferredColorScheme(.none)
        }
    }
}
