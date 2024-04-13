//
//  CoinDataService.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//

import Foundation
import Combine
class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    /*
     Note:
     when we call URLSession.shared.dataTaskPublisher(for: url) which as publisher, then it assume that url could potentialy send us a data over period of time, means publiser assumes it might publish values now and it stays listing in case it has more    publised values in the future.
     But in this example, this url is one time response.
     So its fine if we dont add cancel() subscription in sink after we get response. but best practice we can add it in sink.
     
     */
    
    private func getCoins() {
        
        // Some url can be returning periodic response, and in case we have to cancel that subscription we have to use cancel
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription =
        NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
