//
//  CoinData.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

struct CoinData {
    let name: String
    let code: String
    let imageName: String
}

extension CoinData {
    
    static var coinData: [CoinData] {
        return Chain.testChainList.map { CoinData(name: $0.name, code: $0.code, imageName: $0.imageName ?? "bitcoin" )}
    }
}
