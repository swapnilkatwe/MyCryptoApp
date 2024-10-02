//
//  PreviewProvider.swift
//  MyCryptoApp
//
//  Created by Swapnil Katwe on 12/04/24.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeVM = HomeViewModel()
    
    let stat1 = StatisticModel(title: "Market Cap", value: "$123.23", percentageChange: 20.09)
    let stat2 = StatisticModel(title: "Total Volume", value: "$13.23")
    let stat3 = StatisticModel(title: "Portfolio Volume", value: "$13.2", percentageChange: -15.09)

    let coinModel = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 63932,
        marketCap: 1257128265808,
        marketCapRank: 1,
        fullyDilutedValuation: 1340767241729,
        totalVolume: 32411310095,
        high24H: 66754,
        low24H: 63571,
        priceChange24H: -2409.9580305826094,
        priceChangePercentage24H: -3.63262,
        marketCapChange24H: -48623394735.04907,
        marketCapChangePercentage24H: -3.72379,
        circulatingSupply: 19689990,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 73738,
        athChangePercentage: -13.14685,
        athDate: "2024-03-14T07:10:36.635Z",
        atl: 67.81,
        atlChangePercentage: 94347.23029,
        atlDate: "2013-07-06T00:00:00.000Z", roi: Roi(times: 0.000, currency: .btc, percentage: 0.000),
        lastUpdated: "2024-04-25T09:58:04.778Z",
        sparklineIn7D: SparklineIn7D(price: [
            61263.04132815015,
            61048.751768850336,
            61244.924019478625,
            61346.94257905179,
            61647.656803679194,
            61688.711610830826,
            62641.89298036523,
            62143.345212126136,
            62674.94787799203,
            63537.94287141911,
            63641.49575562413,
            63566.21788008273,
            62827.698817559525,
            63118.38992578757,
            63561.271284468596,
            63473.796819783005,
            63702.6263035617,
            63524.558683375275,
            63517.289856392184,
            62759.9607892424,
            61055.95687671645,
            61100.402174505,
            61765.99096061795,
            62486.375221617476,
            62066.12263082017,
            64576.76501078571,
            64587.66164663983,
            64620.55910455225,
            64846.22305401333,
            64734.87121158928,
            64972.34836570562,
            65079.82263989656,
            64870.43949304431,
            64479.765451855106,
            64471.52983123631,
            64259.103690300995,
            64696.12129408346,
            64188.22689560364,
            64308.30282952848,
            64027.023182702746,
            64383.47711672337,
            64112.51345083991,
            63840.68860508889,
            63606.696326990204,
            63708.833238325686,
            63862.12480739731,
            63968.0631270988,
            64102.57475571032,
            64259.61134777376,
            64088.98827307739,
            63975.74554649415,
            63724.073345885605,
            63712.23861085204,
            63595.28911868955,
            63720.77742016488,
            63851.47472799511,
            63912.555831570324,
            63979.049076926065,
            64808.0413445874,
            64764.828225301055,
            65230.14679487167,
            65011.84960433182,
            64936.27741888656,
            64735.622959073444,
            64717.52552512009,
            64622.874309758576,
            64975.76008691977,
            64783.72839989877,
            64979.69844417978,
            65335.025560536145,
            65205.69247263208,
            65121.759602721424,
            65074.07506231428,
            65080.62413018502,
            65183.28487409905,
            64958.351065800445,
            64919.68834279286,
            65000.95013336604,
            65296.34612807932,
            65041.897239267266,
            64889.9275795219,
            64911.06410587813,
            65068.28472519487,
            64603.93315160502,
            64840.596473468206,
            64761.83230903283,
            64561.17486902658,
            64665.919169858425,
            64734.09359446595,
            65037.483119496384,
            64918.78670332484,
            64894.70962965232,
            64694.72610495621,
            64772.28574069939,
            65854.88294489925,
            65741.63708431351,
            66504.70403000261,
            66343.54643221646,
            66053.00008868682,
            65995.1504515962,
            65924.48739150951,
            66085.36893814267,
            65903.2313928471,
            66048.61211663991,
            66190.79415333882,
            66007.04786229541,
            66010.56841306934,
            66181.50493480705,
            66617.89026941896,
            66325.46619812233,
            66566.99577119658,
            66492.40079409441,
            66565.69942765807,
            67067.07426890385,
            66840.15252625803,
            67027.16640103911,
            66805.38228587815,
            66594.3404025997,
            66528.26650702258,
            66276.49350577158,
            66544.66485375879,
            66371.42178783428,
            66146.4227616896,
            66270.89037357467,
            66083.96541599411,
            66265.27015271189,
            66118.01317131074,
            66095.5295428948,
            66531.27565923118,
            66919.56349733032,
            66419.58385026935,
            66748.99135604917,
            66775.01748128147,
            66795.0687787739,
            66467.37012706687,
            66301.47760555138,
            66373.88017250161,
            66378.52010527095,
            66428.98997797654,
            66748.63448581826,
            66796.09251500791,
            66558.19452585842,
            66600.54145538375,
            67020.41398889829,
            66753.70180974081,
            66754.51866628118,
            66650.45560127326,
            66513.6144398818,
            66342.11333619761,
            66437.65626184577,
            66611.8691758279,
            66319.37966624473,
            65939.34328499576,
            65162.40510947867,
            64749.11323819757,
            64714.40857487322,
            64823.92306621507,
            64076.66656090625,
            63980.14781473364,
            64064.845007852666,
            64306.17796186013,
            64079.72006562455,
            64279.51812857524,
            64526.65700353316,
            64126.14632672102,
            64255.61302129936,
            64244.22225715455,
            64316.5497816889
          ]),
        priceChangePercentage24HInCurrency: -3.6326217381255583,
        currentHoldings: 1.5)
}
