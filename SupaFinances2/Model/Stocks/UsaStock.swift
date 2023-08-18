//
//  UsaStock
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import Foundation

struct UsaStockResponse: Codable {
    let price: Decimal
    let change_point: Decimal
    let change_percentage: Decimal
    let total_vol: String
}

class UsaStockViewModel: ObservableObject, Identifiable {
    let price: Decimal
    let change_point: Decimal
    let change_percentage: Decimal
    let total_vol: String
    
    init(usaStock: UsaStockResponse){
        self.price = usaStock.price
        self.change_point = usaStock.change_point
        self.change_percentage = usaStock.change_percentage
        self.total_vol = usaStock.total_vol
    }
}
