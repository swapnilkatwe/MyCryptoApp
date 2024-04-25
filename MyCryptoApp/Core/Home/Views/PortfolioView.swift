//
//  PortfolioView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 17/04/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantity: String = ""
    @State private var showCheckmark: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    ScrollView(.horizontal, showsIndicators: true) {
                        coinLogoList
                    }
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XmarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButton
                }
            }

            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoins()
                }
            }
        }
    }
}

extension PortfolioView {

    private var coinLogoList: some View {
        LazyHStack(spacing: 10, content: {
            ForEach(vm.searchText.isEmpty ? vm.portfolioCoin : vm.allCoins) { coin in
                CoinLogoView(coin: coin)
                    .frame(width: 75)
                    .padding(4)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            updateSelectedCoins(coin: coin)
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                lineWidth: 1
                            )
                    )
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                
            }
            Divider()
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Ex 1.4", text: $quantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValues().asCurrencyWith2Decimals())
                
            }
        }
        .animation(.none, value: 0)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantity) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    //MARK: - Helper functions
    private func updateSelectedCoins(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoins = vm.portfolioCoin.first(where: { $0.id == coin.id }),
           let amount = portfolioCoins.currentHoldings {
            quantity = "\(amount)"
        } else {
            quantity = ""
        }
        
    }

    private func getCurrentValues() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantity) else { return }

        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)

        withAnimation(.easeIn) {
            showCheckmark  = true
            removeSelectedCoins()
        }

        // Hide keyboard
        UIApplication.shared.endEditing()

        // Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeInOut) {
                showCheckmark = false
            }
        }
    }

    private func removeSelectedCoins() {
        selectedCoin = nil
        vm.searchText = ""
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
