//
//  MarketView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct MarketView: View {
    @EnvironmentObject var data: CryptoAppData
    @State var selectedDuration = "All"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showSettings = false
    @State private var showFavorites = false
    @State private var searchText = ""
    @State private var search = false
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .center) {
                        HeaderAmountView(title: data.strings.totalMarketCap, availableBalance: "$ 123,456.789", todayChangedAmount: "$ 1,234")
                        Spacer()
                            .frame(height: 32)
                        HomeSection(sectionName: data.strings.wathcList, imageType: .image(image: Image("plus"))) {
                            showFavorites.toggle()
                        }
                        Spacer()
                            .frame(height: 16)
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(data.favoriteTokenList.map { ChainViewModel(chain: $0) }) { chain in
                                    GeometryReader { geometry in
                                        NavigationLink(destination: GraphView()) {
                                            CardView(vm: chain)
                                                .rotation3DEffect(
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
                        .offset(x: -20, y: 0)
                        HomeSection(sectionName: data.strings.coins, imageType: .none)
                            .padding(.top, 24)
                            .padding(.bottom, 8)
                            .id(100)
                        if search {
                            CustomTextField(text: $searchText, leadingImageName: "search", leadingImageColor: Colors.blue70White70, trailingImageName: "close", trailingImageColor: Colors.blue70White70, placeholderText: data.strings.searchCoins) {
                                UIApplication.shared.endEditing(true)
                                searchText = ""
                                search.toggle()
                            }
                            .padding(.bottom, 16.0)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach([data.strings.all, data.strings.marketCap, data.strings.price, data.strings.change24Hour], id: \.self) { item in
                                    Button {
                                        selectedDuration = item
                                    } label: {
                                        CustomText(name: item, textColor: Colors.blue70White70, alignment: .center, font: Fonts.semiBoldFont14, lineLimit: 1)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 4)
                                            .if(selectedDuration == item) { content in
                                                content
                                                    .background(Colors.brownBrown20)
                                                    .cornerRadius(20)
                                                    .transition(.move(edge: .top))
                                            }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.leading, 20.0)
                            .animation(.easeInOut(duration: 0.2), value: selectedDuration)
                        }
                        .padding(.trailing, -20)
                        .padding(.leading, -10)
                        Spacer().frame(height: 16)
                        VStack(spacing: 10) {
                            ForEach(data.tokenList.map{ ChainViewModel(chain: $0)}) { chain in
                                HomeThinnerCardView(vm: chain)
                            }
                            
                            Spacer()
                        }
                        .frame(minHeight: 400.0)
                    }
                    .padding(.horizontal, 20)
                }
                .background(
                    BackgroundGradientView()
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        search.toggle()
                        if search {
                            withAnimation(.easeIn) {
                                proxy.scrollTo(100, anchor: .top)
                            }
                        }
                    }) {
                        Image("search")
                            .padding(.trailing, 12)
                    }
                )
                .sheet(isPresented: $showSettings) {
                    HomeView()
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ToolbarContentView(title: data.strings.market)
                    }
                }
                .scrollViewTransparentNavigation()
                .navigationDestination(isPresented: $showFavorites, destination: {
                    AddFavoriteView(viewModel: data.favoriteChainViewModel)
                })
                .onAppear() {
                    selectedDuration = data.strings.all
                }
                .animation(.easeIn(duration: 0.2), value: search)
                .onChange(of: searchText) { value in
                    data.tokenViewModel.filterTokens(containing: value.trimmed)
                }
                .onDisappear() {
                    searchText = ""
                    search = false
                }
            }
        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView().environmentObject(CryptoAppData())
    }
}
