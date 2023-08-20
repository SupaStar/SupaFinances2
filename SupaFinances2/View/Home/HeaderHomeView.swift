//
//  HeaderHomeView
//  SupaFinances2
//
//  Created by Obed Martinez on 18/08/23
//



import SwiftUI

struct HeaderHomeView: View {
    // MARK: PROPERTIES
    let ammount: Double
    
    var ammountFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: ammount)) ?? ""
    }
    // MARK: BODY
    var body: some View {
        VStack(spacing: 20){
            Text("Monto total aproximado")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            Text(ammountFormatted)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
        }//: VSTACK
    }
}

struct HeaderHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderHomeView(ammount: 100)
    }
}
