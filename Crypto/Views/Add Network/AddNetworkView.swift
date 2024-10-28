//
//  AddNetworkView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct AddNetworkView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var searchText: String = ""
    @State var amount: String = "120"
    @StateObject private var viewModel: AddNetworkViewModel
    private var sectionName: String
    private let tokenSelectedUpdateSwapView: ((AddNetwork) -> Void)?
    
    var isAddNetwork: Bool {
        sectionName == "Networks"
    }
    
    init(viewModel: AddNetworkViewModel, sectionName: String? = nil, handler: ((AddNetwork) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.sectionName = sectionName ?? "Networks"
        self.tokenSelectedUpdateSwapView = handler
    }
    
    var body: some View {
        GeometryReader { mainView in
            ScrollView {
                VStack {
                    CustomTextField(text: $searchText, leadingImageName: "search", leadingImageColor: Colors.blue70White70, trailingImageName: "close", trailingImageColor: Colors.blue70White70, placeholderText:  isAddNetwork ? data.strings.searchCurrency : getSearchBarPlaceHolder()) {
                        UIApplication.shared.endEditing(true)
                        searchText = ""
                    }
                    Spacer().frame(height: 24)
                    if sectionName == "Coin Lists" ||  sectionName == "Trending Coins" {
                        
                    } else {
                        HomeSection(sectionName: sectionName == "Networks" ? data.strings.networks : sectionName, imageType: .none)
                    }
                    
                    VStack(spacing: 10) {
                        ForEach(viewModel.addNetworkList) { item in
                            switch isAddNetwork {
                            case true:
                                NavigationLink(destination: SendDetailView()) {
                                    AddNetworkCardView(vm: item) {
                                        viewModel.handleNetworkToggle(for: item)
                                    }
                                }
                            case false:
                                //switch sectionName == "Assets" {
                                switch sectionName == data.strings.assets {
                                case true:
                                    Button {
                                        tokenSelectedUpdateSwapView?(item)
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        AddNetworkCardView(vm: item, action: {
                                            viewModel.handleNetworkToggle(for: item)
                                        }, isAddNetwork: false)
                                    }
                                case false:
                                    GeometryReader { subView in
                                        HomeThinnerCardView(
                                                vm: ChainViewModel(chain: chain(from: item)))
                                            .scaleEffect(
                                                scaleValue(
                                                    mainFrame: mainView.frame(in: .global).minY,
                                                    minY: subView.frame(in: .global).minY))
                                    }
                                    .frame(height: 100)
                                }
                            }
                        }
                    }
                }
                .padding(24)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(
                    leading: Button(action: {
                        searchText = ""
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("back")
                            .padding(.leading, 12)
                    }
                )
                .if(isAddNetwork, content: { content in
                    content.toolbar {
                        ToolbarItem(placement: .principal) {
                            ToolbarContentView(title: data.strings.addHideTokens, subTitle: "FANTOM OPERA")
                        }
                    }
                })
                .if(!isAddNetwork, content: { content in
                    content.toolbar {
                        ToolbarItem(placement: .principal) {
                            ToolbarContentView(title: data.strings.selectAssets)
                        }
                    }
                })
                .if( sectionName == "Coin Lists", content: { content in
                    content.toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack(spacing: 0) {
                                ToolbarContentView(title: data.strings.coinList)
                            }
                            
                        }
                    }
                })
                .if( sectionName == "Trending Coins", content: { content in
                    content.toolbar {
                        ToolbarItem(placement: .principal) {
                            ToolbarContentView(title: data.strings.trendingCoins)
                        }
                    }
                })
            }
            .scrollViewTransparentNavigation()
            .background(
                BackgroundGradientView()
            )
            .navigationBarBackButtonHidden()
            .onChange(of: searchText) { value in
                viewModel.filterAddNetworkList(containing: value)
            }
        }
    }
    
    private func scaleValue(mainFrame: CGFloat, minY: CGFloat) -> CGFloat {
        let scale = (minY - 24) / mainFrame
        if scale > 1 {
            return 1
        } else {
            return scale
        }
    }
    
    private func getSearchBarPlaceHolder() -> String {
        switch isAddNetwork  {
        case true: return data.strings.searchCurrency
        case false:
            if sectionName == "Coin Lists" {
                return data.strings.searchCoins
            }
            if sectionName == "Trending Coins" {
                return data.strings.searchTrendingCoins
            }
            return data.strings.searchAssets
        }
    }
    
    private func chain(from item: AddNetwork) -> Chain {
        Chain(
            id: item.id,
            name: item.name,
            code: item.code,
            price: item.price,
            amount: item.amount,
            change: item.change,
            imageName: item.imageName)
    }
}

struct AddNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNetworkView(viewModel: AddNetworkViewModel(), sectionName: "coin List")
                .environmentObject(CryptoAppData())
        }
    }
}
