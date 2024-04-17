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
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
}
