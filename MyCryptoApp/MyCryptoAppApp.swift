//
//  MyCryptoAppApp.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 11/04/24.
//

import SwiftUI

@main
struct MyCryptoAppApp: App {
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
