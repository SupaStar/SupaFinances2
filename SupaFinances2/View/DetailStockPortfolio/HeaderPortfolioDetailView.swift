//
//  HeaderPortfolioDetailView
//  SupaFinances2
//
//  Created by Obed Martinez on 22/08/23
//



import SwiftUI

struct HeaderPortfolioDetailView: View {
    // MARK: PROPERTIES
    let name: String
    let quantity: Double
    let priceProm: Double
    let total: Double
    
    func valueFormatted(value:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            HStack{
                Spacer()
                Text(name)
                    .titleForeground()
                Spacer()
            }//: HSTACK
            HStack {
                Text("Titulos \(valueFormatted(value: quantity))")
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(" Precio promedio \(valueFormatted(value: priceProm))")
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal, 10)
            Text("Total: \(valueFormatted(value:total))")
        }//: VSTACK
        .padding()
    }
}

struct HeaderPortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPortfolioDetailView(name: "Fibra Monterrey", quantity: 0, priceProm: 0, total: 120)
            .previewLayout(.sizeThatFits)
    }
}
