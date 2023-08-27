//
//  UsaStock
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

struct UsaStockResponse: Codable {
    let price: Double
    let change_point: Double
    let change_percentage: Double
    let total_vol: String
}

class UsaStockViewModel: ObservableObject, Identifiable {
    let price: Double
    let change_point: Double
    let change_percentage: Double
    let total_vol: String
    
    init(usaStock: UsaStockResponse){
        self.price = usaStock.price
        self.change_point = usaStock.change_point
        self.change_percentage = usaStock.change_percentage
        self.total_vol = usaStock.total_vol
    }
}
