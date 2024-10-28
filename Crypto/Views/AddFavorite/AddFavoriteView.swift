//
//  AddFavoriteView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct AddFavoriteView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: FavoriteChainViewModel
    @State var searchText: String = ""
    
    init(viewModel: FavoriteChainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CustomTextField(text: $searchText, leadingImageName: "search", leadingImageColor: Colors.blue70White70, trailingImageName: "close", trailingImageColor: Colors.blue70White70, placeholderText: data.strings.searchCurrency) {
                    UIApplication.shared.endEditing(true)
                    searchText = ""
                }
                Spacer().frame(height: 24)
                HomeSection(sectionName: data.strings.tokens, imageType: .none)
                VStack(spacing: 10) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Colors.brown)
                    }else {
                        ForEach(viewModel.favoriteTokenList) { item in
                            AddFavoriteCardView(vm: item, onToggle: {
                                viewModel.toggleFavoriteForItem(item)
                            })
                        }
                        .foregroundColor(Colors.blueWhite)
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ToolbarContentView(title: data.strings.addFavorite)
                }
            }
        }
        .scrollViewTransparentNavigation()
        .background(
            BackgroundGradientView()
        )
        .navigationBarBackButtonHidden()
        .onChange(of: searchText) { value in
            viewModel.filterAddFavoriteList(containing: value)
        }
    }
}

struct AddFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        AddFavoriteView(viewModel: FavoriteChainViewModel())
            .environmentObject(CryptoAppData())
    }
}
