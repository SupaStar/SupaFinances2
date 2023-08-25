//
//  UsaStock
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

struct UsaStockSearchResponse: Codable {
    let status: String
    let data: [UsaStockSearch]
}
struct UsaStockSearch: Codable {
    let symbol: String
    let instrument_name: String
    let exchange: String
    let currency: String
    let country: String
}

class UsaStockSearchViewModel: ObservableObject, Identifiable {
    let symbol: String
    let instrument_name: String
    let exchange: String
    let currency: String
    let country: String
    var isSaved: Bool
    
    init(usaStock: UsaStockSearch, isSaved: Bool){
        self.symbol = usaStock.symbol
        self.instrument_name = usaStock.instrument_name
        self.exchange = usaStock.exchange
        self.currency = usaStock.currency
        self.country = usaStock.country
        self.isSaved = isSaved
    }
}
