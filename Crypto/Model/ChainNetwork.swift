//
//  ChainNetwork.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ChainNetwork: Hashable, Codable {
    var id: String
    let name: String
    let imageName: String
}

extension ChainNetwork {
    var iconImage: Image {
        return Image(imageName)
    }
}
