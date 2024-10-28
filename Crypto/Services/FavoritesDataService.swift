//
//  FavoritesDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class FavoritesDataService {
    func getFavorites() -> AnyPublisher<[FavoriteChain], Error> {
        let dataSource = JSONReaderSource(fileName: "favorites")
        return dataSource
            .get([FavoriteChain].self)
            .eraseToAnyPublisher()
    }
}
