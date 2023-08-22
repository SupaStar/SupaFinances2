//
//  HoldModalFormViewModel
//  SupaFinances2
//
//  Created by Obed Martinez on 21/08/23
//



import Foundation

class HoldModalFormViewModel: ObservableObject {
    // MARK: Variables
    @Published var quantityS: String = ""
    @Published var priceS: String = ""
    @Published var dateHold: Date = Date()
    @Published var type: String
    @Published var stock: StockEntity?
    var saved: (() -> Void)?

    // MARK: INJECTIONS
    private var portfolioService: PortafolioService = PortafolioService()
    
    init(type: String, stock: StockEntity?){
        self.type = type
        if let stock = stock {
            self.stock = stock
        }
    }
    
    func save() {
        guard let quantity = Double(quantityS), let price = Double(priceS) else {
            return
        }
        guard let stock = self.stock else {
            return
        }
        portfolioService.addHold(stock: stock, price: price, quantity: quantity, hold_date: dateHold, type: type)
        quantityS = ""
        priceS = ""
        dateHold = Date()
        if let saved = self.saved {
            saved()
        }
    }
}
