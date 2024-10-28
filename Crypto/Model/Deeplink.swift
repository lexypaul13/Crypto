//
//  Deeplink.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

struct Deeplink {
    private init() {}
    
    static let shared =  Deeplink()
    
    let scheme = "crypto"
    
    let host = "chains"
    
    func url(for chain: String) -> URL {
        return  URL(string: "\(scheme)://\(host)/\(chain)")!
    }
    
    func getCode(from url: URL) -> String? {
        guard url.scheme == scheme,
              url.host() == host,
              url.pathComponents.count >= 2 else {
            return nil
        }
        
        return url.pathComponents[1]
    }
}
