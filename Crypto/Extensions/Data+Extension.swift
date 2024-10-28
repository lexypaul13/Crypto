//
//  Data + Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

extension Data {
    
    var jsonString: String? { //prettyPrintedBody
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyPrintedData = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedBody = String(data: prettyPrintedData, encoding: .utf8)
        else {
            return nil
        }
        
        return prettyPrintedBody
    }
    
}
