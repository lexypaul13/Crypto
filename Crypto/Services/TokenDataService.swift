//
//  FileReaderService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class TokenDataService {
    func getTokens() -> AnyPublisher<[Chain], Error> {
        let dataSource = JSONReaderSource(fileName: "tokens")
        return dataSource
            .get([Chain].self)
            .eraseToAnyPublisher()
    }
}
