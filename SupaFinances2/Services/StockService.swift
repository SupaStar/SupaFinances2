//
//  StockService
//  SupaFinances2
//
//  Created by Obed Martinez on 19/08/23
//



import Foundation
import CoreData

class StockService {
    private let container: NSPersistentContainer
    private let containerName: String = "SupaFinancesContainer"
    private let entityName: String = "Stock"
    
    @Published var savedStocks: [Stock] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getStocks()
        }
    }
    
    // MARK: PUBLIC
    
    func addStock(name: String, marketVal: Double, symbol: String){
        add(name: name, marketVal: marketVal, symbol: symbol)
    }
    
    func addHold(stock: Stock, ammount: Double, quantity: Int16){
        let entity = Holding(context: container.viewContext)
        entity.id = UUID()
        entity.date = Date()
        entity.ammount = ammount
        entity.quantity = quantity
        stock.addToHolds(entity)
        applyChanges()
    }
    // MARK: PRIVATE
    
    private func getStocks() {
        let request = NSFetchRequest<Stock>(entityName: entityName)
        do {
            savedStocks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    private func add(name: String, marketVal: Double, symbol: String) {
        let entity = Stock(context: container.viewContext)
        entity.id = UUID()
        entity.name = name
        entity.dateAdd = Date()
        entity.market_value = marketVal
        entity.symbol = symbol
        applyChanges()
    }
    
    private func update(entity: Stock, newData: Stock) {
        entity.market_value = newData.market_value
        entity.symbol = newData.symbol
        applyChanges()
    }
    
    private func delete(entity: Stock) {
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
        getStocks()
    }
}
