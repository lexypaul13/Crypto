//
//  AddNetworkDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class AddNetworkDataService {
    func getNetworks() -> AnyPublisher<[AddNetwork], Error> {
        let dataSource = JSONReaderSource(fileName: "add-networks")
        return dataSource
            .get([AddNetwork].self)
            .eraseToAnyPublisher()
    }
}
