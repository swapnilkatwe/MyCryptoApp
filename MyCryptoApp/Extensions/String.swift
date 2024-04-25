//
//  String.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 25/04/24.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }}
