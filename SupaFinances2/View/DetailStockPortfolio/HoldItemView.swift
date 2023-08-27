//
//  HoldItemView
//  SupaFinances2
//
//  Created by Obed Martinez on 21/08/23
//



import SwiftUI

struct HoldItemView: View {
    // MARK: PROPERTIES
    let date: Date
    let type: String
    let price: Double
    let quantity: Double
    let symbol: String
    
    var total: Double {
        return price * quantity
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func formattedDouble(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                Text("\(symbol.uppercased())")
                    .fontWeight(.bold)
                Spacer()
                Text("Total: $\( formattedDouble(total))")
                    .foregroundColor(textColor)
            }//: HSTACK
            HStack {
                Text("\(type.uppercased()) \(formattedDouble(quantity))")
                Text("$\(formattedDouble(price))")
                Spacer()
                Text("\(formattedDate)")
            }//: HSTACK
        }//: VSTACK
        .padding()
    }
}

struct HoldItemView_Previews: PreviewProvider {
    static var previews: some View {
        HoldItemView(date: Date(), type: "Buy", price: 10, quantity: 20, symbol: "fmty14")
            .previewLayout(.sizeThatFits)
    }
}
