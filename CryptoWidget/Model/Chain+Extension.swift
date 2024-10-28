//
//  Chain+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

extension Chain {
    static var testChainList: [Chain] {
        return [
            Chain(id: "5180533c-4280-11ee-be56-0242ac120002", name: "Bitcoin", code: "BTC", price: 30205.09, amount: 143, change: 0.8, imageName: "bitcoin"),
            Chain(id: "518055f8-4280-11ee-be56-0242ac120002", name: "Ethereum", code: "ETH", price: 1912.89, amount: 120.3234, change: -2.25, imageName: "ethereum"),
            Chain(id: "5180576a-4280-11ee-be56-0242ac120002", name: "Binance Coin", code: "BNB", price: 242.42, amount: 1132151, change: 2.25, imageName: "binance"),
            Chain(id: "51805918-4280-11ee-be56-0242ac120002", name: "Fantom Opera", code: "FTM", price: 0.00, amount: 0, change: 0, imageName: "fantom_opera"),
            Chain(id: "51805af8-4280-11ee-be56-0242ac120002", name: "L3USD", code: "L3USD", price: 0.36, amount: 0, change: 4.919, imageName: "l3usd")
        ]
    }

    static var placeholderChainList: [Chain] {
        Chain.testChainList.shuffled().suffix(2)
    }
    
    static var snapshotChainList: [Chain] {
        Chain.testChainList.shuffled().suffix(4)
    }
}
