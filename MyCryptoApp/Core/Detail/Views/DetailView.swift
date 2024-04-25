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
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {

                    overviewTitle

                    Divider()
                    
                    descriptionSection
                    
                    overViewGrid
                    
                    additionalTitle
                                        
                    Divider()

                    additionalGrid

                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Detail View")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var overViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    Button(action: {
                        withAnimation(.easeOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "less.." : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                            .foregroundStyle(Color.theme.accent)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let websiteUrl = vm.websiteUrl, let url = URL(string: websiteUrl) {
                Link(destination: url, label: {
                    Text("Website")
                })
            }
            
            if let urlString = vm.redditUrl, let url = URL(string: urlString) {
                Link(destination: url, label: {
                    Text("Reddit")
                })
            }
        }
        .tint(Color.theme.accent)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }

    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: [],
                  content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        })
    }
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text("\(vm.coin.symbol.uppercased())")
                .font(.headline)
                .bold()
            .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin: dev.coinModel)
        }
    }
}

