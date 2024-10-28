//
//  Chain.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

struct Chain: Hashable, Decodable {
    let id: String
    let name: String
    let code: String
    let price: Double
    let amount: Double
    let change: Double
    let imageName: String?
}
