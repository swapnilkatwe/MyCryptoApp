//
//  HomeViewModel.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//



// https://www.youtube.com/watch?v=TlJUMVKtUhc&list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu&index=7

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    
    private let dataService = CoinDataService()
    // To cancel any subscription
    private var cancellables = Set<AnyCancellable>()

    
    init() {
        addSubscriber()
        
        //Code before api call to mock data
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coinModel)
            self.portfolioCoin.append(DeveloperPreview.instance.coinModel)
        }
        */
    }
    
    // Now we need to list allCoins from this model with allCoins from coinDataService.
    // the reason is, when we initialise dataService here then allCoins in coinDataService will get all data in (@publised)allCoin variable after url call.
    
    func addSubscriber() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
