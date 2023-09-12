//
//  MarketStockEntity+CoreDataProperties
//  
//
//  Created by Obed Martinez on 11/09/23
//


//

import Foundation
import CoreData


extension MarketStockEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MarketStockEntity> {
        return NSFetchRequest<MarketStockEntity>(entityName: "MarketStockEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var value: Double

}
