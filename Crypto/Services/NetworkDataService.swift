//
//  NetworkDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class NetworkDataService {
    func getNetworks() -> AnyPublisher<[ChainNetwork], Error> {
        let dataSource = JSONReaderSource(fileName: "networks")
        return dataSource
            .get([ChainNetwork].self)
            .eraseToAnyPublisher()
    }
}

