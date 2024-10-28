//
//  FavoriteChainViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class FavoriteChainViewModel: ObservableObject {
    @Published var favoriteTokenList: [FavoriteChain]
    @Published var isLoading: Bool
    private var cancellables = Set<AnyCancellable>()
    private var allFavoriteTokenList: [FavoriteChain]
    private let favoritesService: FavoritesDataService
    
    init() {
        allFavoriteTokenList = []
        favoriteTokenList = []
        favoritesService = FavoritesDataService()
        isLoading = false
    }
    
    // fetch favorites
    func fetchFavorites() {
        isLoading = true
        favoritesService
            .getFavorites()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { tokens in
                self.allFavoriteTokenList = tokens
                self.favoriteTokenList = tokens
            }
            .store(in: &cancellables)
    }
}

extension FavoriteChainViewModel {
    
    func filterAddFavoriteList(containing text: String) {
        guard !text.isEmpty else{
            favoriteTokenList = allFavoriteTokenList
            return
        }
        favoriteTokenList = allFavoriteTokenList.filter{ $0.name.lowercased().contains(text.lowercased()) }
    }
    
    func toggleFavoriteForItem(_ item: FavoriteChain) {
        let filteredTokenNames = favoriteTokenList.map { $0.name }
        
        if let index = allFavoriteTokenList.firstIndex(where: { $0.name == item.name }) {
            let newFavorite = allFavoriteTokenList[index].toggleFavorite()
            allFavoriteTokenList[index] = newFavorite
        }
        favoriteTokenList = allFavoriteTokenList.filter{ filteredTokenNames.contains($0.name) }
    }
}
