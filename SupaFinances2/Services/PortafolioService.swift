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
        let entity = StockEntity(context: container.viewContext)
        entity.name = name
        entity.added_date = Date()
        entity.value = marketVal
        entity.symbol = symbol
        entity.country = country
        portfolio.addToStocks(entity)
        applyChanges()
    }
    
    func addHold(stock: StockEntity, price: Double, quantity: Double, hold_date: Date){
        let entity = HoldingEntity(context: container.viewContext)
        entity.id = UUID()
        entity.date = Date()
        entity.price = price
        entity.quantity = quantity
        entity.hold_date = hold_date
        entity.date = Date()
        stock.addToHolds(entity)
        applyChanges()
    }
    // MARK: PRIVATE
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortafolioEntity>(entityName: entityName)
        do {
            portFolios = try container.viewContext.fetch(request)
            if portFolios.isEmpty {
                addPortfolio(name: "Inversiones")
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
        let request = NSFetchRequest<StockEntity>(entityName: stockEntityName)
        do {
            savedStocks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
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
