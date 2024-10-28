//
//  Transaction.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import SwiftUI

enum TransactionType {
    case send
    case receive
}

extension TransactionType {
    
    var chainActionName: String {
        switch self {
        case .send:
            return "Sent"
        case .receive:
            return "Received"
        }
    }
    
    var addressActionName: String {
        switch self {
        case .send:
            return "To"
        case .receive:
            return "From"
        }
    }
}

extension TransactionType {
    var transactionTintColor: Color {
        switch self {
        case .send:
            return Colors.red
        case .receive:
            return Colors.green
        }
    }
}

struct Transaction: Identifiable, Decodable {
    
    let id: String
    
    let name: String
    
    let code: String
    
    let address: String
    
    let amount: Double
    
    let date: String
    
    let action: String
    
    let imageName: String?
}

extension Transaction {
    var transactionType: TransactionType {
        if action == "send" {
            return .send
        }
        
        return .receive
    }
    
    var chainName: String {
        name
    }
    
    var transactionDate: Date? {
        date.toDate(dateFormat: "yyyy-MM-dd HH:mm:ss Z")
    }
    
    var isDateToday: Bool {
        return transactionDate?.isDateToday ?? false
    }
}

struct TransactionItemViewModel: Identifiable {
    
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var id: String { transaction.id }
    
    var iconImage: Image { transaction.imageName != nil ? Image(transaction.imageName!) : Image("placeholder") }
    
    var title: String { "\(transaction.transactionType.chainActionName) \(transaction.chainName)" }
    
    var subtitle: String { "\(transaction.transactionType.addressActionName): \(transaction.address)" }
    
    var transactionAmount: String {
        
        let prefix = transaction.transactionType == .send ? "-" : ""
        
        return "\(prefix)\(transaction.amount.fractionNumber) \(transaction.code)"
    }
    
    var date: String { transaction.transactionDate?.toString(format: "MMM d yyyy") ?? "" }
    
    var transactionAmountTintColor: Color { transaction.transactionType.transactionTintColor }
}

extension Date {
    var isDateToday: Bool {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        
        /// We will consider the current date as Aug 24, 2023
        /// Remove this for real data and use Date() instead of date24 in todayComponents from parameter
        /// let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        var components = DateComponents()
        components.year = 2023
        components.month = 8
        components.day = 24
        let date24 = calendar.date(from: components)
        
        let todayComponents = calendar.dateComponents([.year, .month, .day], from: date24 ?? Date())
        
        return dateComponents.year == todayComponents.year &&
               dateComponents.month == todayComponents.month &&
               dateComponents.day == todayComponents.day
    }
}
