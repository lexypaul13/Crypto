//
//  AddNetwork.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import SwiftUI

enum AddNetworkType: String {
    case hide = "Hide"
    case add = "Add"
}

struct AddNetwork: Identifiable, Codable {
    let id: String
    let name: String
    let imageName: String
    let amount: Double
    let added: Bool
    var code: String
    var change: Double
    var price: Double
}

extension AddNetwork {
    var actionType: AddNetworkType {
        added ? .hide : .add
    }
    
    var displayAmount: String {
        "\(amount) \(code)"
    }
}
extension AddNetwork {
    func updateActionType(to type: AddNetworkType) -> AddNetwork {
        return AddNetwork(id: id, name: name, imageName: imageName, amount: amount, added: (type != .add), code: code, change: change, price: price)
    }
}

extension AddNetworkType {
    var tintColor: Color {
        switch self {
        case .hide:
            return Colors.blue70White70
        case .add:
            return Colors.brown
        }
    }
}

extension AddNetwork {
    var iconImage: Image { Image(imageName) }
    
    var actionTintColor: Color { actionType.tintColor }
}
