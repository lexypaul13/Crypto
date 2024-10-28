//
//  Int + extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var string: String {
        return String(self)
    }
}
