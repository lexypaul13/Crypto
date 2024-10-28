//
//  LocalStorage.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct LocalStorage {
    private init(){}
    
    static let shared = LocalStorage()
    
    ///Identifies if a user is logged-in or logged-out
    @AppStorage("isUserLoggedIn") var isUserLoggedIn: Bool = false
    
    ///Identifies the app language selected by the user
    @AppStorage("selectedLanguage") var selectedLanguage: String?
}
