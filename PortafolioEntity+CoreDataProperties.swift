//
//  PortafolioEntity+CoreDataProperties
//  
//
//  Created by Obed Martinez on 21/08/23
//


//

import Foundation
import CoreData


extension PortafolioEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PortafolioEntity> {
        return NSFetchRequest<PortafolioEntity>(entityName: "PortafolioEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var stocks: NSSet?

}

// MARK: Generated accessors for stocks
extension PortafolioEntity {

    @objc(addStocksObject:)
    @NSManaged public func addToStocks(_ value: StockEntity)

    @objc(removeStocksObject:)
    @NSManaged public func removeFromStocks(_ value: StockEntity)

    @objc(addStocks:)
    @NSManaged public func addToStocks(_ values: NSSet)

    @objc(removeStocks:)
    @NSManaged public func removeFromStocks(_ values: NSSet)

}
