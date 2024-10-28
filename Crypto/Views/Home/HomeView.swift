//
//  HomeView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct HomeView: View {
    
    enum NextView: String {
        case coinList, trendingCoins, none
        var sectionName: String {
            String(describing: self).capitalizeFirstLetter.camelCaseToWords()
        }
    }
    
    @EnvironmentObject var data: CryptoAppData
    @State private var showSettings = false
    @State private var showNotification = false
    @State private var showCoinList = false
    @State private var showTrendingCoins = false
    @State private var selectedChain: Chain? = nil
    @State private var showChain: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center) {
                    GeometryReader { geometry in
                        HeaderAmountView(title: data.strings.availableBalance, availableBalance: "$ 123,456.789", todayChangedAmount: "$ 1,234")
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .scaleEffect(GlobalFunctions.scale(for: geometry))
                            .offset(y: GlobalFunctions.offset(for: geometry))
                            .padding(.top, GlobalFunctions().getNavigationBarHeight())
                    }
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(height: 198) // Adjust the desired height of the image
                    
                    Spacer()
                        .frame(height: 32)
                    HomeSection(sectionName: data.strings.coinList) {
                        showCoinList = true
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(data.tokenList.map{ ChainViewModel(chain: $0)}) { chain in
                                GeometryReader { geometry in
                                    NavigationLink(destination: GraphView()) {
                                        CardView(vm: chain).rotation3DEffect(
                                                Angle(degrees: Double(geometry.frame(in: .global).minX) / -20),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                    }
                                }
                            }
                            .frame(width: 240, height: 150)
                        }
                        .padding(.leading, 20)
                    }
                    .scrollIndicators(.hidden)
                    .padding(.trailing, -40)
                    .offset(x: -20, y: 0) // Apply initial position
                    Spacer().frame(height: 24)
                    HomeSection(sectionName: data.strings.trendingCoins) {
                        showTrendingCoins = true
                    }
                    VStack(spacing: 10) {
                        ForEach(data.tokenList, id: \.self) { chain in
                            HomeThinnerCardView(vm: ChainViewModel(chain: chain))
                                .onTapGesture {
                                    data.setSelectedChain(chain)
                                }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .background(
                BackgroundGradientView()
            )
            .scrollViewTransparentNavigation()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                }) {
                    Image("user1")
                },
                trailing: NavigationLink(destination: NotificationView(viewModel: data.notificationViewModel), label: {
                    Image("notification.fill")
                })
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ToolbarContentView(title: data.strings.dashboard)
                }
            }
            .sheet(isPresented: $showSettings) {
                HomeView()
            }
            .navigationDestination(isPresented: $showCoinList, destination: {
                AddNetworkView(viewModel: data.addNetworkViewModel, sectionName: "Coin Lists")
            })
            .navigationDestination(isPresented: $showTrendingCoins, destination: {
                AddNetworkView(viewModel: data.addNetworkViewModel, sectionName: "Trending Coins")
            })
            .navigationDestination(isPresented: $showChain, destination: {
                GraphView()
            })
            .onChange(of: data.selectedChain) { newValue in
                if let _ = newValue {
                    showChain = true
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(CryptoAppData())
    }
}
