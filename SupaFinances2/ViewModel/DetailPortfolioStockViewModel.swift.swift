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
        guard let stock = self.stock else {
            isLoading = false
            return
        }
        if let holds = stock.holds {
            self.holds = holds.allObjects as! [HoldingEntity]
            self.holds.sort { (hold1, hold2) in
                return hold1.hold_date! > hold2.hold_date!
            }
            for hold in self.holds {
                total += hold.price * hold.quantity
            }
        }
        self.isLoading = false
    }
    func refreshHold () {
        isLoading = true
        guard let stock = self.stock else {
            isLoading = false
            return
        }
        servicePortfolio.findHold(stock: stock, symbol: nil)
        guard let newStock = servicePortfolio.stockSelected else {
            return
        }
        self.stock = newStock
        loadHolds()
    }
}
