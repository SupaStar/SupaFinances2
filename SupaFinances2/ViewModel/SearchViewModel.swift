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
    // MARK: INJECTIONS
    private var disposables = Set<AnyCancellable>()
    private var service: StocksService = StocksService()
    private var local: PortafolioService = PortafolioService()
    init(){
        $searchText
            .sink(receiveValue: loadStocks(searchTerm:))
            .store(in: &disposables)
    }
    private func loadStocks(searchTerm: String) {
        if searchTerm.isEmpty {
            return
        }
      stocks.removeAll()
    
        service.searchStocks(search: searchTerm, completion: { (stocks, error) in
            if let error = error {
                return
            }
            stocks.forEach { self.appendStock(stock: $0) }
        })
    }
    
    private func appendStock(stock: UsaStockSearch) {
        let saved = isSaved(stock: stock)
        let stockVM = UsaStockSearchViewModel(usaStock: stock, isSaved: saved)
        DispatchQueue.main.async {
            self.stocks.append(stockVM)
        }
    }
    
    private func isSaved(stock: UsaStockSearch) -> Bool {
        if let existingStock = local.savedStocks.first(where: {
                if let entity = $0 as? StockEntity,
                   entity.symbol == stock.symbol,
                   entity.country == stock.country {
                    return true
                }
                return false
            }) {
                print("El símbolo ya está registrado: \(stock.symbol), país: \(stock.country)")
                return true
            }
            return false
    }
}
