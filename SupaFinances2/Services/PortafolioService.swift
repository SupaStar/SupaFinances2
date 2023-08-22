//
//  StockService
//  SupaFinances2
//
//  Created by Obed Martinez on 19/08/23
//



import Foundation
import CoreData

class PortafolioService {
    private let container: NSPersistentContainer
    private let containerName: String = "SupaFinancesContainer"
    private let entityName: String = "PortafolioEntity"
    private let stockEntityName: String = "StockEntity"
    private let holdingEntityName: String = "HoldingEntity"
    
    @Published var stockSelected: StockEntity?
    @Published var savedStocks: [StockEntity] = []
    @Published var portFolios: [PortafolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    
    func addStock(name: String, marketVal: Double, symbol: String,country: String, portfolio: PortafolioEntity){
        if let existingStock = portfolio.stocks?.first(where: { ($0 as? StockEntity)?.symbol == symbol }) as? StockEntity {
            // El símbolo ya existe, no se necesita crear un nuevo objeto
            print("El símbolo ya está registrado: \(symbol)")
            // Aquí puedes realizar otras acciones si es necesario
            return
        }
        let entity = StockEntity(context: container.viewContext)
        entity.name = name
        entity.added_date = Date()
        entity.value = marketVal
        entity.symbol = symbol
        entity.country = country
        portfolio.addToStocks(entity)
        applyChanges()
    }
    
    func addHold(stock: StockEntity, price: Double, quantity: Double, hold_date: Date, type: String = "Buy"){
        let entity = HoldingEntity(context: container.viewContext)
        entity.id = UUID()
        entity.date = Date()
        entity.price = price
        entity.quantity = quantity
        entity.hold_date = hold_date
        entity.date = Date()
        entity.type = type.lowercased()
        stock.addToHolds(entity)
        save()
    }
    
    func removeAllStocks(){
        for savedStock in savedStocks {
            container.viewContext.delete(savedStock)
        }
        applyChanges()
    }
    
    func deleteStocks(stocks: [StockEntity]){
        for stock in stocks {
            container.viewContext.delete(stock)
        }
        applyChanges()
    }
    
    func deleteHolds(holds: [HoldingEntity]) {
        for hold in holds {
            container.viewContext.delete(hold)
        }
        applyChanges()
    }
    
    func getHolds(stock: StockEntity) -> [HoldingEntity] {
        guard let stock = findStock(stock: stock, symbol: nil) else {
            return []
        }
        if let holds = stock.holds {
            var holdsS = holds.allObjects as! [HoldingEntity]
            holdsS.sort { (hold1, hold2) in
                return hold1.hold_date! > hold2.hold_date!
            }
            return holdsS
        }
        return []
    }
    
    func findStock(stock: StockEntity?, symbol: String?) -> StockEntity? {
        var symbolF = ""
        if let stock = stock {
            guard let symbolS = stock.symbol else {
                return nil
            }
            symbolF = symbolS
        }
        if let symbol = symbol {
            symbolF = symbol
        }
        if let stockSel = savedStocks.first(where: { $0.symbol == symbolF }) {
            return stockSel
        }
        return nil
    }
    // MARK: PRIVATE
    
    func refreshStockData(stock: StockEntity){
        if let holds = stock.holds {
            let savedHolds = holds.allObjects as! [HoldingEntity]
            var totalPrice: Double = 0
            var totalQuantity: Double = 0
            for hold in savedHolds {
                if hold.type == "buy"{
                    totalPrice += hold.price * hold.quantity
                    totalQuantity += hold.quantity
                } else {
                    totalPrice -= hold.price * hold.quantity
                    totalQuantity -= hold.quantity
                }
            }
            stock.price_prom = totalPrice / Double(savedHolds.count)
            stock.quantity = totalQuantity
            applyChanges()
        }
    }
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortafolioEntity>(entityName: entityName)
        do {
            portFolios = try container.viewContext.fetch(request)
            if portFolios.isEmpty {
                addPortfolio(name: "Inversiones")
                getPortfolio()
            } else {
                getStocks()
            }
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    private func addPortfolio(name: String){
        let entity = PortafolioEntity(context: container.viewContext)
        entity.id = UUID()
        entity.name = name
        applyChanges()
    }
    
    private func getStocks() {
        guard let portfolio = portFolios.first else {
            return
        }
        if let stocks = portfolio.stocks {
            savedStocks = stocks.allObjects as! [StockEntity]
            savedStocks.sort { (stock1, stock2) in
                return stock1.added_date! < stock2.added_date!
            }
            //            for stock in savedStocks {
            //                if let holds = stock.holds {
            //                    let savedHolds = holds.allObjects as! [HoldingEntity]
            //                    var totalPrice: Double = 0
            //                    var totalQuantity: Double = 0
            //                    for hold in savedHolds {
            //                        totalPrice += hold.price * hold.quantity
            //                        totalQuantity += hold.quantity
            //                    }
            //                    stock.price_prom = totalPrice / totalQuantity
            //                    stock.quantity = totalQuantity
            //                    save()
            //                }
            //            }
        }
    }
    
    private func update(entity: StockEntity, newData: StockEntity) {
        entity.value = newData.value
        entity.symbol = newData.symbol
        applyChanges()
    }
    
    private func delete(entity: StockEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
