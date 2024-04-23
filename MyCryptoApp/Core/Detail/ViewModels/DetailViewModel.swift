//
//  DetailViewModel.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 23/04/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()

    init(coin: CoinModel) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coindetails
            .sink { returnedCoinDetails in
                print("Received coin details data: \n \(returnedCoinDetails)")
            }
            .store(in: &cancellable)
    }
}
