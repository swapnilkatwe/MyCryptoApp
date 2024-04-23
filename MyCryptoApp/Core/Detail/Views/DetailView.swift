//
//  DetailView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 22/04/24.
//

import SwiftUI

struct detailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    let coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        print("Initialising detail view for \(coin.name)")
    }
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coinModel)
    }
}

