//
//  Decimal+Double+Extension.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import UIKit

fileprivate let currencyBehavior = NSDecimalNumberHandler(
                                        roundingMode: .bankers,
                                        scale: 2,
                                        raiseOnExactness: false,
                                        raiseOnOverflow: false,
                                        raiseOnUnderflow: false,
                                        raiseOnDivideByZero: true)

extension Decimal {
    var rC: Decimal {
        return (self as NSDecimalNumber).rounding(accordingToBehavior: currencyBehavior) as Decimal
    }
    
    var dollar: String {
        return Formatter.withCurrencySeparator.string(for: self) ?? ""
    }
    
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

extension Formatter {
    static let withCurrencySeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .currency
        return formatter
        //Result = $123,456.11
    }()
    
    static let withoutCurrencySeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return formatter
        //Result = 23,456.11
    }()
    
    static let minFraction0: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        return formatter
        //Result =  123.23
    }()
    
}

extension Double {
    var dollar: String {
        return Formatter.withCurrencySeparator.string(for: self) ?? ""
    }
    
    var fractionNumber: String {
        return Formatter.minFraction0.string(for: self) ?? ""
    }
    
    var fractionNumberPercent: String {
        return "\(self.fractionNumber) %"
    }
    
    var string: String {
        return String(self)
    }
    
    var zeroIfNegative: Double {
        return self < 0 ? 0 : self
    }
}

extension String {
    var fractionNumber: String {
        return Formatter.minFraction0.string(for: Double(self)) ?? ""
    }
    
    var decimal: Decimal {
        return Decimal(Double(self) ?? 0)
    }
    
    var fractionNumberDouble: Double {
        return Double(Formatter.minFraction0.string(for: Double(self)) ?? "") ?? 0
    }
    
    var toCGFLoat: CGFloat {
        return CGFloat((self as NSString).doubleValue)
    }
}
