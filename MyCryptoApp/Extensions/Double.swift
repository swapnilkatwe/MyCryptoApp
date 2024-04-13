//
//  Double.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//

import Foundation

extension Double {
    ///Converts double into a currancy with 2 decimal places
    ///```
    ///Convert 1234.567 = $1234.56
    ///```
    private var currancyFormater2: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current
//        formater.currencyCode = "nok"
//        formater.currencySymbol = "kr"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        return formater
    }
    
    ///Converts double into a currancy as a String with 2 decimal places
    ///```
    ///Convert 1234.567 = "$1234.56"
    ///```
    func asCurrencyWith2Decimals() -> String {
        let currancy = NSNumber(value: self)
        return currancyFormater2.string(from: currancy) ?? "$0.00"
    }
    ///Converts double into a currancy with 2-6 decimal places
    ///```
    ///Convert 1234.567 = $1234.56
    ///Convert 12.3456 = $12.3456
    ///Convert 0.1234567 = $0.123456
    ///```
    private var currancyFormater6: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current
//        formater.currencyCode = "nok"
//        formater.currencySymbol = "kr"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        return formater
    }
    
    ///Converts double into a currancy as a String with 2-6 decimal places
    ///```
    ///Convert 1234.567 = "$1234.56"
    ///Convert 12.3456 = "$12.3456"
    ///Convert 0.1234567 = "$0.123456"
    ///```
    func asCurrencyWith6Decimals() -> String {
        let currancy = NSNumber(value: self)
        return currancyFormater6.string(from: currancy) ?? "$0.00"
    }
    
    /// Converts Double to String
    func asNumberString() -> String {
        return String(format: "%0.2f", self)
    }
    
    /// Converts Double to String with % symbol
    func asPercenstString() -> String {
        return asNumberString() + "%"
    }
}
