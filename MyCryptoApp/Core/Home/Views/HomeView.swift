//
//  HomeView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 11/04/24.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()

            //Content Layer
            VStack(spacing: 0) {
                
                homeHeder
                
                HomeStatisticView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)

                columnTitle

                if !showPortfolio {
                    allCoinsView
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinView
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            
        }
    }
}

extension HomeView {
    private var homeHeder: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)

    }
    
    private var allCoinsView: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinView: some View {
        List {
            ForEach(vm.portfolioCoin) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var columnTitle: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.accent)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(HomeViewModel())
}
