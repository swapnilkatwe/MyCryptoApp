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
    @Published var sortOption: SortOptions = .holings

    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()

    private let portfolioDataService = PortfolioDataService()

    // To cancel any subscription
    private var cancellables = Set<AnyCancellable>()

    enum SortOptions {
        case rank, rankReversed, holings, holdingsReversed, price, priceReversed
    }
    
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
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                print("-> all coins with search text")
            }
            .store(in: &cancellables)


        // Updates PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoin = self.softPortfolioCoinsIfNeeded(coins: returnedCoins)
                print("--> all coins map to prortfolio")
            }
            .store(in: &cancellables)
        
        // MarketData subscriber Updates Market Data. This is used to show Statisitic data on homeView
        marketDataService.$marketData
            .combineLatest($portfolioCoin)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                print("---> all coins with market data service")
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOptions) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        //sort
        sortCoins(sort: sort, coin: &updatedCoins)
        return updatedCoins
    }

    private func mapAllCoinsToPortfolioCoins(coinModels: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel]  {
        coinModels.compactMap { currentCoin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { $0.coinId == currentCoin.id }) else {
                return nil
            }
            return currentCoin.updateHoldings(amount: entity.amount)
        }
    }
    // Here we using inout so use same coinModel array to sort and use is make little more memmory efficient than normal way.
    // Regular way you can return newly created coinModel array every time you sort the array.
    private func sortCoins(sort: SortOptions, coin: inout [CoinModel]) {
        switch sort {
        case .rank, .holings:
             coin.sort(by: { $0.rank < $1.rank })
            
        case .rankReversed, .holdingsReversed:
             coin.sort(by: { $0.rank > $1.rank })
            
        case .price:
             coin.sort(by: { $0.currentPrice > $1.currentPrice })
        
        case .priceReversed:
             coin.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func softPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        // Only sort by holding or holdingreversed if Needed
        switch sortOption {
        case .holings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    
        
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let marketData = marketDataModel else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap", value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: marketData.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)

        let portfolioValue = portfolioCoins
                                .map({$0.currentHoldingsValue })
                                .reduce(0, +)
        
        let previousValue = portfolioCoins.map { coin -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentageChange = (coin.priceChangePercentage24H ?? 0.0) / 100
            let previousValue = currentValue / (1 + percentageChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        let portfolio = StatisticModel(title: "Portfolio Value",
                                       value: portfolioValue.asCurrencyWith2Decimals(),
                                       percentageChange: percentageChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}


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

/*
 .map { (coinModels, portfolioEntities) -> [CoinModel] in
     coinModels.compactMap { currentCoin -> CoinModel? in
         guard let entity = portfolioEntities.first(where: { $0.coinId == currentCoin.id }) else {
             return nil
         }
         return currentCoin.updateHoldings(amount: entity.amount)
     }
 }
 
 */
