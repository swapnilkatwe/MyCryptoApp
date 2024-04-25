//
//  ChartView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 23/04/24.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let minY: Double
    private let maxY: Double
    private let lineColor: Color
    private let startDate: Date
    private let endDate: Date
    @State private var percentage: CGFloat = 0.0
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
        
    }

    // X calculation
    // 300
    // 100
    // 3
    // 1 indices * 3 = 3
    // 2 * 3 = 6
    // 100 * 3 = 300
    
    // y axis
    // 60000 - 50000 = 10000
    // 52000 data point
    // 52000-50000 = 2000 Bottom / 10000 = 20%
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .overlay(alignment: .leading, content: { 
                    chartYaxisView
                        .padding(.horizontal, 5)
                })
                .background(chartBackground)

            chartDetailLabels
                .padding(.vertical, 4)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coinModel)
    }
}

extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosision = (1 - CGFloat((data[index] - minY)) / yAxis) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosision))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosision))
                }
            }
            .trim(from: 0, to: percentage) // to animate chart line
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }

    private var chartYaxisView: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((minY + maxY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDetailLabels: some View {
        HStack {
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}

