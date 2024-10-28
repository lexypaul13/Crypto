//
//  TokenContactDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class TokenContactDataService {
    func getContacts() -> AnyPublisher<[TokenContact], Error> {
        let dataSource = JSONReaderSource(fileName: "token-contacts")
        return dataSource
            .get([TokenContact].self)
            .eraseToAnyPublisher()
    }
}
