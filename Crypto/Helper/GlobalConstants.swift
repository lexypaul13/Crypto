//
//  GlobalConstants.swift
//
//
//  Copyright © 2023 Amrit Duwal. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftUI
import Combine

struct GlobalConstants {
    
    struct Image {
        static let placeholder: UIImage = UIImage(named: "logo") ?? UIImage()
    }
    
    class KeyValues: ObservableObject {

        @Published var watchSelecteCurrency: String = "USD" {
            didSet {
                saveData()
            }
        }
        
        init() {
            loadData()
        }
        
        private func saveData() {
            UserDefaults.standard.set(watchSelecteCurrency, forKey: "watchSelecteCurrency")
        }
        
        private func loadData() {
            if let value = UserDefaults.standard.string(forKey: "watchSelecteCurrency") {
                watchSelecteCurrency = value
            }
        }
        
        
        static func apiCache<T: Codable>(key: String) -> T? {
            let cache = UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]
            guard let data = cache?[key] else {return nil}
            do {
                return try JSONDecoder().decode(T.self, from: data)
            }catch {
                debugPrint(error)
                return nil
            }
        }
        
        static func apiCache<T: Codable>(key: String, data: T) {
            var cache = (UserDefaults.standard.dictionary(forKey: "URLCache") as? [String: Data]) ?? [:]
            cache[key] = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(cache, forKey: "URLCache")
        }
        
        static private func encodeAndSave<T: Encodable>(key: String, value: T) {
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
        
        
        static private func decode<T: Decodable>(key: String) -> T? {
            if let data = UserDefaults.standard.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: data)
            }
            return nil
        }
    }
    
    struct Error {
        static var oops: NSError { NSError(domain: "API_ERROR", code: 500, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])}
    }
    
}


class GlobalData: ObservableObject {
    let sharedDefaults = UserDefaults(suiteName: "group.com.virtual-gravity.CryptoApp")
    @Published var watchSelecteCurrency: String = "USD" {
        didSet {
            saveData()
        }
    }
    
    init() {
        loadData()
    }
    
    private func saveData() {
        sharedDefaults?.set(watchSelecteCurrency, forKey: "watchSelecteCurrency")
    }
    
    private func loadData() {
        if let value = sharedDefaults?.string(forKey: "watchSelecteCurrency") {
            watchSelecteCurrency = value
        }
    }
    
}
