//
//  CoinRowView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    var body: some View {
        
        HStack(spacing: 0) {
            leftCoulumView
            Spacer()
            if showHoldingsColumn  { centerColumn }
            rightColumn
        }
        .font(.subheadline)
    }
}

extension CoinRowView {
    
    private var leftCoulumView: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(width: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
                .frame(height: 30)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)

            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green :
                        Color.theme.red
                )
        }
        // Warning:  UIScreen is depricating so use geometry or ther option instead
        // for only portrait mode, or use geometry
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
    }
}

//#Preview {
//    CoinRowView(coin: dev.coinModel)
//}

struct CoinRowView_Preview: PreviewProvider {
    static var previews: some View {
            CoinRowView(coin: dev.coinModel, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
    }
}
