//
//  HoldingEntity+CoreDataProperties
//  
//
//  Created by Obed Martinez on 06/09/23
//


//

import Foundation
import CoreData


extension HoldingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HoldingEntity> {
        return NSFetchRequest<HoldingEntity>(entityName: "HoldingEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var hold_date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Double
    @NSManaged public var type: String?
    @NSManaged public var stock: StockEntity?

}
