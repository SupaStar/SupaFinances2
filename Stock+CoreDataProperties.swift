//
//  Stock+CoreDataProperties
//  
//
//  Created by Obed Martinez on 19/08/23
//


//

import Foundation
import CoreData


extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var dateAdd: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var market_value: Double
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var holds: NSSet?

}

// MARK: Generated accessors for holds
extension Stock {

    @objc(addHoldsObject:)
    @NSManaged public func addToHolds(_ value: Holding)

    @objc(removeHoldsObject:)
    @NSManaged public func removeFromHolds(_ value: Holding)

    @objc(addHolds:)
    @NSManaged public func addToHolds(_ values: NSSet)

    @objc(removeHolds:)
    @NSManaged public func removeFromHolds(_ values: NSSet)

}
