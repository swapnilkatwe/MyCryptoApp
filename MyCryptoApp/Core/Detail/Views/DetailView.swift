//
//  DetailView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 22/04/24.
//

import SwiftUI

// This view is added to load DetailView through it because to check if coin is not nil and avoid detailView to loading if nil coin
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
    @StateObject var vm: DetailViewModel

    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initialising detail view for \(coin.name)")
    }
    var body: some View {
        Text("Body")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coinModel)
    }
}

