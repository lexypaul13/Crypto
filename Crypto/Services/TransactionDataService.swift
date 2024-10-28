//
//  TransactionDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class TransactionDataService {
    func getTransactions() -> AnyPublisher<[Transaction], Error> {
        let dataSource = JSONReaderSource(fileName: "transactions")
        return dataSource
            .get([Transaction].self)
            .eraseToAnyPublisher()
    }
}
