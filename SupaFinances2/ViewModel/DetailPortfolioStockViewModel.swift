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
    @Published var totalMercado: Double = 0
    @Published var plusMinus: Double = 0
    @Published public private(set) var isLoading: Bool = false
    @Published var form: HoldViewModel?
    @Published var newCtoProm: Double?
    @Published var showToast: Bool = false
    @Published var toastTitle: String = ""
    @Published var desiredTitles: Double?
    @Published var weekAmmount: Double?
    
    private var servicePortfolio: PortafolioService = PortafolioService()
    init(stock: StockEntity?) {
        self.stock = stock ?? nil
        loadHolds()
    }
    
    func refreshStock() -> Bool {
        guard let newStock = servicePortfolio.findStock(stock: stock, symbol: nil) else {
            return false
        }
        self.stock = newStock
        return true
    }
    
    func loadHolds(){
        isLoading = true
        if !refreshStock() {
            isLoading = false
            return
        }
        self.newCtoProm = stock?.price_prom
        self.desiredTitles = stock?.desired_titles
        self.weekAmmount = stock?.week_ammount
        self.holds = servicePortfolio.getHolds(stock: self.stock!)
        total = 0
        totalMercado = 0
        for hold in holds {
            if hold.type == "buy" {
                self.total += hold.price * hold.quantity
            } else {
                self.total -= hold.price * hold.quantity
            }
        }
        if let quantity = stock?.quantity, let price = stock?.value, let price_prom = stock?.price_prom {
            totalMercado = quantity * price
            plusMinus = (price/price_prom) - 1
        }
        self.isLoading = false
    }
    
    func refreshHold(isEdit: Bool = false) {
        isLoading = true
        if !refreshStock() {
            isLoading = false
            return
        }
        servicePortfolio.refreshStockData(stock: self.stock!, isEdit: isEdit)
        loadHolds()
    }
    
    func deleteHolds(offsets: IndexSet) {
        let selectedHolds = offsets.map { holds[$0] }
        servicePortfolio.deleteHolds(holds: selectedHolds)
        showToast.toggle()
        toastTitle = "Registro eliminado."
        refreshHold()
    }
    
    func saveHold() {
        isLoading = true
        guard let hold = form else {
            isLoading = false
            return
        }
        
        if !refreshStock() {
            isLoading = false
            return
        }
        
        toastTitle = "Guardado con exito."
        showToast.toggle()
        
        servicePortfolio.addHold(stock: self.stock!, price: hold.price, quantity: hold.quantity, hold_date: hold.dateHold, type: hold.type)
        refreshHold()
    }
    
    func editCtoProm() {
        isLoading = true
        if !refreshStock() {
            isLoading = false
            return
        }
        if let newCtoProm = self.newCtoProm {
            servicePortfolio.editPriceProm(stock: self.stock!, newPrice: newCtoProm)
        }
        if let weekAmmount = self.weekAmmount, let desiredTitles = self.desiredTitles {
            servicePortfolio.editAmmount(stock: self.stock!, newAmmount: weekAmmount)
            servicePortfolio.editDesiredTitles(stock: self.stock!, newAmmount: desiredTitles)
        }
        refreshHold(isEdit: true)
    }
}
