//
//  StockEntity+CoreDataProperties
//  
//
//  Created by Obed Martinez on 19/08/23
//


//

import Foundation
import CoreData


extension StockEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockEntity> {
        return NSFetchRequest<StockEntity>(entityName: "StockEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var value: Double
    @NSManaged public var added_date: Date?
    @NSManaged public var country: String?
    @NSManaged public var portfolio: PortafolioEntity?
    @NSManaged public var holds: NSSet?

}

// MARK: Generated accessors for holds
extension StockEntity {

    @objc(addHoldsObject:)
    @NSManaged public func addToHolds(_ value: HoldingEntity)

    @objc(removeHoldsObject:)
    @NSManaged public func removeFromHolds(_ value: HoldingEntity)

    @objc(addHolds:)
    @NSManaged public func addToHolds(_ values: NSSet)

    @objc(removeHolds:)
    @NSManaged public func removeFromHolds(_ values: NSSet)

}
