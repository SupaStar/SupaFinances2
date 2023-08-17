//
//  Constant
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import Foundation
import CoreData


// API
func urlMexico(serie:String) -> String {
    return "https://api.databursatil.com/v1/precios?token=7691abe453d7a49c098b345eabfea0&emisora_serie=\(serie)&bolsa=BMV,BIVA"
}

let dolarMxn = "https://api.exchangerate.host/latest?base=USD&symbols=MXN"

let busqueda = "https://twelve-data1.p.rapidapi.com/symbol_search"

func urlUSA(serie: String) -> String {
    return "https://realstonks.p.rapidapi.com/\(serie)"
}
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
