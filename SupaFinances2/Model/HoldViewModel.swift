//
//  HoldViewModel
//  SupaFinances2
//
//  Created by Obed Martinez on 23/08/23
//



import Foundation

class HoldViewModel: Equatable {
    let quantity: Double
    let price: Double
    let type: String
    let dateHold: Date
    
    init(quantity: Double, price: Double, type: String, dateHold: Date) {
        self.quantity = quantity
        self.price = price
        self.type = type
        self.dateHold = dateHold
    }
    
    static func == (lhs: HoldViewModel, rhs: HoldViewModel) -> Bool {
            // Aquí debes comparar las propiedades relevantes para determinar si dos HoldViewModel son iguales
            // Por ejemplo:
        return lhs.dateHold == rhs.dateHold
    }
}
