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
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()

    private let portfolioDataService = PortfolioDataService()

    // To cancel any subscription
    private var cancellables = Set<AnyCancellable>()

    
    init() {
        addSubscribers()
        
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
    
    func addSubscribers() {

        // Update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
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

        // MarketData subscriber Updates Market Data. This is used to show Statisitic data on homeView
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
        
        // Updates PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels.compactMap { currentCoin -> CoinModel? in
                    guard let entity = portfolioEntities.first(where: { $0.coinId == currentCoin.id }) else {
                        return nil
                    }
                    return currentCoin.updateHoldings(amount: entity.amount)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.portfolioCoin = returnedCoins
            }
            .store(in: &cancellables)
            
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let marketData = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: marketData.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "0.0", percentageChange: 0.0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
