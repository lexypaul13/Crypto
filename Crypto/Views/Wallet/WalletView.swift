//
//  WalletView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.colorScheme) var colorScheme
    @State private var showSettings = false
    @State var showPopup: Bool = false
    @State private var search: Bool = false
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    VStack {
                        HeaderAmountView(title: data.strings.availableBalance, availableBalance: "$ 123,456.789", todayChangedAmount: "$ 1,234")
                        Spacer().frame(height: 26)
                        HStack(spacing: 12) {
                            NavigationLink {
                                SendView()
                            } label: {
                                TextWithImage(todayChangedAmount: data.strings.send, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("send"), imageForegroundColor: Colors.blueWhite, verticalPadding: 8, cornerRadius: 30)
                            }
                            
                            NavigationLink {
                                ReceiveView()
                            } label: {
                                TextWithImage(todayChangedAmount: data.strings.receive, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("receive"), imageForegroundColor: Colors.blueWhite, verticalPadding: 8, cornerRadius: 30)
                            }
                            
                            NavigationLink {
                                SwapView()
                            } label: {
                                TextWithImage(todayChangedAmount: data.strings.swap, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("swap"), imageForegroundColor: Colors.blueWhite, verticalPadding: 8, cornerRadius: 30)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        Spacer().frame(height: 26)
                        if search {
                            CustomTextField(text: $searchText, leadingImageName: "search", leadingImageColor: Colors.blue70White70, trailingImageName: "close", trailingImageColor: Colors.blue70White70, placeholderText: data.strings.searchCoins) {
                                UIApplication.shared.endEditing(true)
                                searchText = ""
                                search.toggle()
                            }
                            .transition(.move(edge: .trailing))
                        }else {
                            HomeSection(sectionName: data.strings.coins, imageType: .image(image: Image("search"))) {
                                search.toggle()
                            }
                            .transition(.move(edge: .leading))
                            .frame(height: 48.0)
                        }
                        VStack(spacing: 10) {
                            ForEach(data.tokenList.map{ ChainViewModel(chain: $0)}) { chain in
                                NavigationLink(destination: GraphView()) {
                                    HomeThinnerCardView(vm: chain)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .scrollViewTransparentNavigation()
                .if(showPopup) { content in
                    content
                        .offset(y: 94)
                        .blur(radius: 2)
                }
                if showPopup {
                    ZStack {
                        BackgroundGradientView()
                            .blur(radius: 20)
                            .opacity(0.9)
                        VStack {
                            SelectNetworkView(viewModel: data.chainNetworkViewModel, showPopup: $showPopup)
                                .padding(.vertical, 0)
                                .padding(.horizontal, 24.0)
                            Spacer()
                        }
                        .if(colorScheme == .dark) { content in
                            content
                                .offset(y: 94)
                        }
                    }
                }
            }
            .background(
                BackgroundGradientView()
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Image("bitcoin"),
                trailing: NavigationLink(destination: AddNetworkView(viewModel: data.addNetworkViewModel)) {
                    Image("plus")
                }
            )
            .sheet(isPresented: $showSettings) {
                HomeView()
            }
            .animation(.easeIn(duration: 0.2), value: search)
            .onChange(of: searchText) { value in
                data.tokenViewModel.filterTokens(containing: value)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button {
                        showPopup.toggle()
                    } label: {
                        ToolbarContentView(title: data.chainNetworkViewModel.selectedNetwork?.name ?? "", titleTrailingImage: Image("downArrow"))
                    }
                }
            }
            .onDisappear() {
                searchText = ""
                search = false
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
            .environmentObject(CryptoAppData())
    }
}
