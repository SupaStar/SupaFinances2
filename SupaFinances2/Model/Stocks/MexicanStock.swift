//
//  MexicanStock
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

struct MexicanStockResponse: Codable {
    let BMV: MexicanStock
    let BIVA: MexicanStock
}
struct MexicanStock: Codable {
    let ultimo: Double
    let ppp: Double
    let tiempo: String
}

class MexicanStockViewModel: Identifiable, ObservableObject {
    let ultimo: Double
    let ppp: Double
    let tiempo: String
    
    init(mexicanStock: MexicanStock){
        self.ultimo = mexicanStock.ultimo
        self.ppp = mexicanStock.ppp
        self.tiempo = mexicanStock.tiempo
    }
}
