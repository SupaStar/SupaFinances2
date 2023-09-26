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
    let totalMarket: Double
    let plusMinus: Double
    
    var plusMinusForm: String {
        if plusMinus.isNaN || plusMinus.isInfinite {
            return "0%"
        }
        let percentageFormatter = NumberFormatter()
        percentageFormatter.numberStyle = .percent
        if let formattedPercentage = percentageFormatter.string(from: NSNumber(value: plusMinus)) {
            return formattedPercentage
        } else {
            return ""
        }
    }
    
    var textoPlus: String {
        if plusMinus < 0 {
            return "Minusvalia"
        } else if plusMinus == 0 {
            return ""
        } else {
            return "Plusvalia"
        }
    }
    
    var colorPlusMinus: Color {
        if plusMinus < 0 {
            return Color.red
        } else if plusMinus > 0 && plusMinus.isFinite {
            return Color.green
        }else {
            return Color.gray
        }
    }
    
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
            HStack {
                Text("Total: \(valueFormatted(value:total))")
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("Valor de mercado: \(valueFormatted(value:totalMarket))")
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal, 10)
            HStack{
                Text("\(textoPlus)")
                Text("\(plusMinusForm)")
                    .foregroundColor(colorPlusMinus)
            }
        }//: VSTACK
        .padding()
    }
}

struct HeaderPortfolioDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPortfolioDetailView(name: "Fibra Monterrey", quantity: 0, priceProm: 0, total: 120, totalMarket: 100, plusMinus: 6)
            .previewLayout(.sizeThatFits)
    }
}
