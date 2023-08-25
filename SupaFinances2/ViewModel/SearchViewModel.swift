//
//  SearchViewModel
//  SupaFinances2
//
//  Created by Obed Martinez on 25/08/23
//



import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    // MARK: VARIABLES
    @Published var searchText: String = ""
    @Published var stocks: [UsaStockSearchViewModel] = []
    private var portfolio: PortafolioEntity?
    // MARK: INJECTIONS
    private var disposables = Set<AnyCancellable>()
    private var service: StocksService = StocksService()
    private var local: PortafolioService = PortafolioService()
    init(){
        $searchText
            .sink(receiveValue: loadStocks(searchTerm:))
            .store(in: &disposables)
        self.portfolio = local.portFolios[0]
    }
    
    private func loadStocks(searchTerm: String) {
        if searchTerm.isEmpty {
            return
        }
        stocks.removeAll()
        
        service.searchStocks(search: searchTerm, completion: { (stocks, error) in
            if error != nil {
                return
            }
            stocks.forEach { self.appendStock(stock: $0) }
        })
    }
    
    private func appendStock(stock: UsaStockSearch) {
        let saved = isSaved(symbol: stock.symbol, country: stock.country)
        let stockVM = UsaStockSearchViewModel(usaStock: stock, isSaved: saved)
        DispatchQueue.main.async {
            self.stocks.append(stockVM)
        }
    }
    
    private func isSaved(symbol: String, country: String) -> Bool {
        if let existingStock = local.savedStocks.first(where: {
            if let entity = $0 as? StockEntity,
               entity.symbol == symbol,
               entity.country == country {
                return true
            }
            return false
        }) {
            print("El símbolo ya está registrado: \(symbol), país: \(country)")
            return true
        }
        return false
    }
    
    
    func saveStock(stock: UsaStockSearchViewModel){
        guard let portfolio = self.portfolio else {
            return
        }
        local.addStock(name: stock.instrument_name, marketVal: 10.0, symbol: stock.symbol, country: stock.country, portfolio: portfolio)
        self.refresh()
    }
    private func refresh(){
        let chargedStocks = self.stocks
        self.stocks.removeAll()
        chargedStocks.forEach({ value in
            let isSaved = isSaved(symbol: value.symbol, country: value.country)
            value.isSaved = isSaved
            self.stocks.append(value)
        })
    }
}
