//
//  UsdMxnModel
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

struct ExchangeRateResponse: Codable {
    struct Motd: Codable {
        let msg: String
        let url: String
    }
    
    let motd: Motd
    let success: Bool
    let base: String
    let date: String
    let rates: Rate
}

struct Rate: Codable {
    let MXN: Double
}

class ExchangeViewModel: Identifiable, ObservableObject {
    let success: Bool
    var base: String
    let date: String
    let rates: RateViewModel

    var rateMXN: String {
        return "$\(self.rates.MXN)"
    }
    
    init(exchange: ExchangeRateResponse) {
        self.success = exchange.success
        self.base = exchange.base
        self.date = exchange.date
        self.rates = RateViewModel(rate: exchange.rates)
    }
}

class RateViewModel: Identifiable, ObservableObject {
    let MXN: Double
    
    init(rate: Rate) {
        self.MXN = rate.MXN
    }
}
