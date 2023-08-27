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
    @Published var isLoading: Bool = false
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
        isLoading = true
        stocks.removeAll()
        
        service.searchStocks(search: searchTerm, completion: { (stocks, error) in
            if error != nil {
                self.isLoading = false
                return
            }
            stocks.forEach { self.appendStock(stock: $0) }
            DispatchQueue.main.async {
                self.isLoading = false
            }
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
        local = PortafolioService()
        self.portfolio = local.portFolios.first
        let stocks = local.savedStocks
        
        if stocks.first(where: {
            if let entity = $0 as? StockEntity,
               entity.symbol == symbol,
               entity.country == country {
                return true
            }
            return false
        }) != nil {
            print("El símbolo ya está registrado: \(symbol), país: \(country)")
            return true
        }
        return false
    }
    
    
    func saveStock(stock: UsaStockSearchViewModel){
        guard let portfolio = self.portfolio else {
            return
        }
        if stock.isSaved {
            return
        }
        var precio: Double = 0
        if stock.country == "Mexico" {
            self.service.showMexicanStock(stockSymbol: stock.symbol, completion: { (response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let response = response else {
                    return
                }
                precio = response.ultimo
                print("mexico \(response)")
                DispatchQueue.main.async {
                    self.saveStockEntity(stock: stock, portfolio: portfolio, price: precio)
                }
            })
        } else {
            self.service.showUsaStock(stockSymbol: stock.symbol, completion: {
                (response, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let response = response else {
                    return
                }
                precio = response.price
                print("otra \(response)")
                DispatchQueue.main.async {
                    self.saveStockEntity(stock: stock, portfolio: portfolio, price: precio)
                }
            })
        }
        
        
    }
    
    func saveStockEntity(stock: UsaStockSearchViewModel, portfolio: PortafolioEntity, price: Double){
        local.addStock(name: stock.instrument_name, marketVal: price, symbol: stock.symbol, country: stock.country, portfolio: portfolio)
        self.refresh()
    }
    private func refresh(){
        isLoading = true
        let chargedStocks = self.stocks
        self.stocks.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            chargedStocks.forEach({ value in
                let isSaved = self.isSaved(symbol: value.symbol, country: value.country)
                value.isSaved = isSaved
                self.stocks.append(value)
            })
            self.isLoading = false
        })
    }
}
