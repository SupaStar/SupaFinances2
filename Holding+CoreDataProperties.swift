//
//  Holding+CoreDataProperties
//  
//
//  Created by Obed Martinez on 19/08/23
//


//

import Foundation
import CoreData


extension Holding {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Holding> {
        return NSFetchRequest<Holding>(entityName: "Holding")
    }

    @NSManaged public var ammount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var quantity: Int16
    @NSManaged public var stock: Stock?

}
