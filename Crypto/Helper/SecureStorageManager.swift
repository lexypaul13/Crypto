//
//  SecureStorageManager.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

enum SecureStorageError: Error {
    case duplicateEntry
    case unknown(OSStatus)
}

struct SecureStorageManager {
    
    private init() {}
    
    static let shared = SecureStorageManager()
    
    func save(service: String, account: String, label: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrLabel as String: label
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw SecureStorageError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw SecureStorageError.unknown(status)
        }
    }
    
    func update(service: String, account: String, label: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecAttrLabel as String: label
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status == errSecSuccess else {
            throw SecureStorageError.unknown(status)
        }
    }
    
    func get(service: String, account: String, label: String) throws -> Data? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrLabel as String: label
          ]

      var data: AnyObject?
      let status = SecItemCopyMatching(query as CFDictionary, &data)

      guard status == errSecSuccess || status == errSecItemNotFound else {
        throw SecureStorageError.unknown(status)
      }

      guard status != errSecItemNotFound else {
        return nil
      }
      
      return data as? Data
    }
    
    func delete(service: String, account: String, label: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecAttrLabel as String: label
          ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw SecureStorageError.unknown(status)
        }
    }
}
