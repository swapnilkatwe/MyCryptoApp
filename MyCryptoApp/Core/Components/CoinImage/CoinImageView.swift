//
//  CoinImageView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 15/04/24.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var viewModel: CoinImageViewModel

    init(coin: CoinModel) {
        /*
            // if you try viewModel = CoinImageViewModel(coin: coin)
            // Cannot assign to property: 'viewModel' is a get-only property
            //
            We can not reference directly to viewModel as its a state object,
            So we have to use _viewModel to reference the state object of above viewModel
        */

        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.accent)
            }
        }
    }
}

struct CoinImageView_Preview: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coinModel)
            .previewLayout(.sizeThatFits)
    }
}

//@available(iOS 17.0, *)
//#Preview(traits: .sizeThatFitsLayout) {
//    CoinImageView(coin:)
//        .padding()
//}
