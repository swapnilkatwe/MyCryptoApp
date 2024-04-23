//
//  HomeView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 11/04/24.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // Animate to right
    @State private var showPortfolioView: Bool = false // New sheet
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })

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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
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
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
        .navigationDestination(isPresented: $showDetailView, destination: {
            detailLoadingView(coin: $selectedCoin)
        })
    }
    
    private var portfolioCoinView: some View {
        List {
            ForEach(vm.portfolioCoin) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(.plain)
        .navigationDestination(isPresented: $showDetailView, destination: {
            detailLoadingView(coin: $selectedCoin)
        })
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }

    private var columnTitle: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ?  1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }

            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holings || vm.sortOption == .holdingsReversed) ?  1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holings ? 0 : 180))

                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holings ? .holdingsReversed : .holings
                    }
                }
            }
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ?  1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))

            }
            .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }

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
