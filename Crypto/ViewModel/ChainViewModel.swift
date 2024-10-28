//
//  ChainViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ChainViewModel: Identifiable {
    
    private let chain: Chain
    
    init(chain: Chain) {
        self.chain = chain
    }
    
    var id: String {
        chain.id
    }
    
    var name: String { chain.name }
    
    var code: String { chain.code.uppercased() }
    
    var amount: String { chain.amount.fractionNumber }
    
    var changePercent: String {
        let mod = abs(chain.change)
        
        return "\(chain.change < 0 ? "-" : "+") \(mod.fractionNumberPercent)"
    }
    
    var dollarPrice: String {
        return chain.price.dollar
    }
    
    var image: Image {
        if let imageName = chain.imageName {
            return Image(imageName)
        }else {
            return Image("placeholder")
        }
    }
    
    var changeTint: Color {
        chain.change < 0 ? Colors.red : Colors.green
    }
}
