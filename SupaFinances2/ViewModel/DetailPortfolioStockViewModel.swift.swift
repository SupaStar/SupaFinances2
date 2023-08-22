//
//  DetailPortfolioStockViewModel.swift
//  SupaFinances2
//
//  Created by Obed Martinez on 19/08/23
//



import Foundation
class DetailPortfolioStockViewModel: ObservableObject {
    @Published var stock: StockEntity?
    @Published var holds: [HoldingEntity] = []
    @Published var total: Double = 0
    @Published public private(set) var isLoading: Bool = false
    
    private var servicePortfolio: PortafolioService = PortafolioService()
    init(stock: StockEntity?) {
        self.stock = stock ?? nil
        loadHolds()
    }
    
    func loadHolds(){
        isLoading = true
        guard let stock = servicePortfolio.findStock(stock: stock, symbol: nil) else {
            isLoading = false
            return
        }
        self.holds = servicePortfolio.getHolds(stock: stock)
        self.isLoading = false
    }
    
    func refreshHold() {
        isLoading = true
        guard let stock = self.stock else {
            isLoading = false
            return
        }
        guard let newStock = servicePortfolio.findStock(stock: stock, symbol: nil) else {
            return
        }
        servicePortfolio.refreshStockData(stock: newStock)
        self.stock = newStock
        loadHolds()
    }
    
    func deleteHolds(offsets: IndexSet) {
        let selectedHolds = offsets.map { holds[$0] }
        servicePortfolio.deleteHolds(holds: selectedHolds)
        refreshHold()
    }
}
