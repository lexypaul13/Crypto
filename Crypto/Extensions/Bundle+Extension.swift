//
//  Bundle+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

extension Bundle {
    static func localeBundle(_ lang: String) -> Bundle {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            return Bundle.main
        }
        
        return Bundle(path: path) ?? Bundle.main
    }
}
