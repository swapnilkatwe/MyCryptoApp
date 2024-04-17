//
//  HomeStatisticView.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 17/04/24.
//

import SwiftUI

struct HomeStatisticView: View {
    @Binding var showPortfolio: Bool
    @EnvironmentObject private var vm: HomeViewModel
    #warning("UIScreen.main is getting depricated in future so use geometry or other solution to get screen size")
    var body: some View {
        HStack {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

//#Preview {
//    HomeStatisticView(showPortfolio: .constant(false))
//        .environmentObject(dev.homeVM)
//}
struct HomeStatisticView_Preview: PreviewProvider {
    static var previews: some View {
        HomeStatisticView(showPortfolio: .constant(false))
                .environmentObject(dev.homeVM)
    }
}
