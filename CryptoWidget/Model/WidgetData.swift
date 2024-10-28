//
//  WidgetData.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import Foundation
import SwiftUI

class WidgetData: ObservableObject {
    
    @Published var chainList: [Chain]
    
    @Published var totalAmount: Double
    
    @Published var changePercent: Double
    
    init() {
        chainList = Chain.testChainList
        
        totalAmount = 123456789.99
        
        changePercent = 1.04
    }
    
    var changeTintColor: Color {
        changePercent >= 0 ? Colors.green : Colors.red
    }
    
    func findChain(named name: String) -> Chain? {
        return chainList.filter { $0.name.lowercased() == name.lowercased() }.first
    }
    
    func findChains(in names: [String]) -> [Chain] {
        
        var chains: [Chain] = []
        
        for name in names {
            
            if let chain = findChain(named: name) {
                chains.append(chain)
            }
        }
        return chains
    }
}
