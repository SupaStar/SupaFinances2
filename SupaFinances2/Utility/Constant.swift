//
//  Constant
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import Foundation
import CoreData
import SwiftUI


// API
func urlMexico(serie:String) -> String {
    return "https://api.databursatil.com/v1/precios?token=7691abe453d7a49c098b345eabfea0&emisora_serie=\(serie)&bolsa=BMV,BIVA"
}


let urlDolarMxn = "https://api.exchangerate.host/latest?base=USD&symbols=MXN"

let urlbusqueda = "https://twelve-data1.p.rapidapi.com/symbol_search"

func urlUSA(serie: String) -> String {
    return "https://realstonks.p.rapidapi.com/\(serie)"
}


// UI
let primaryColor: Color = Color("Primary")
let textColor: Color = Color("Text")


// DATA


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
