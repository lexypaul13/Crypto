//
//  SecurityViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

class SecurityViewModel {
    
    private let service: String
    private let account: String
    private let label: String
    
    init() {
        service = "cryptoApp"
        account = "user"
        label = "passcode"
    }
    
    func getPasscode() -> String? {
        do {
            let data = try SecureStorageManager.shared.get(
                service: service,
                account: account,
                label: label)
            
            guard let data = data else {
                print("data is nil")
                return nil
            }
            
            return String(data: data, encoding: .utf8)
        }catch {
            print(error)
            return nil
        }
    }
    
    func savePasscode(data passcodeData: Data) throws {
        try SecureStorageManager.shared.save(
                service: service,
                account: account,
                label: label,
                data: passcodeData)
    }
    
    func deletePasscode() throws {
        try SecureStorageManager.shared.delete(
                service: service,
                account: account,
                label: label)
    }
}
