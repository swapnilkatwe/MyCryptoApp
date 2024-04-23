//
//  CoinDetailDataService.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 23/04/24.
//

import Foundation
import Combine

class CoinDetailDataService {

    @Published var coindetails: CoinDetailModel? = nil
    let coin: CoinModel
    var coinDetailSubscription: AnyCancellable?

    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetails()
    }
    
    private func getCoinsDetails() {
        
        // Some url can be returning periodic response, and in case we have to cancel that subscription we have to use cancel
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription =
        NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coindetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
