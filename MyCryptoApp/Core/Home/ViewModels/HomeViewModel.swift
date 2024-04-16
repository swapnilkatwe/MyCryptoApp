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
    @Published var searchText: String = ""
    
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

        // Update all coins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        /*
         Before adding search functionality, we could use this code to return coins.
         But for filter logic we have combined dataService with searchText publisher as above.
         
         Below is simple code to get allCoins
         
         dataService.$allCoins
         .sink { [weak self] returnedCoins in
         self?.allCoins = returnedCoins
         }
         .store(in: &cancellables)
         */
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {

        guard !text.isEmpty else {
            return coins
        }
        let lowercaseText = text.lowercased()

        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercaseText) ||
            coin.symbol.lowercased().contains(lowercaseText) ||
            coin.id.lowercased().contains(lowercaseText)
        }
    }
}
