//
//  UIApplication.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 16/04/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
