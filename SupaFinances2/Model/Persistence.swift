//
//  Persistence
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SupaFinancesContainer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // ITEM
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        // STOCK
        let fmty = Stock(context: viewContext)
        fmty.id = UUID()
        fmty.dateAdd = Date()
        fmty.market_value = 11.49
        fmty.name = "Fibra Monterrey"
        fmty.symbol = "FMTY14"
        let danhos = Stock(context: viewContext)
        danhos.id = UUID()
        danhos.dateAdd = Date()
        danhos.market_value = 20.82
        danhos.name = "Fibra Danhos"
        danhos.symbol = "DANHOS13"
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
