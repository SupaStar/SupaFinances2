//
//  Constant
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import Foundation
import CoreData
// DATA
func sampleStock() -> Stock {
    let fmty = Stock()
    fmty.id = UUID()
    fmty.dateAdd = Date()
    fmty.market_value = 11.49
    fmty.name = "Fibra Monterrey"
    fmty.nomenclature = "FMTY14"
    return fmty
}


// FORMATTERS
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

let marketValueFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$"
    return formatter
}()
func stringFormatter(string: Any) -> String {
    return "\(string)"
}
