//
//  StockView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI

struct StockItemView: View {
    // MARK: PROPERTIES
    @State var variation: Double = -100.0
    let title: String
    let symbol: String
    let value: Double
    let cto_prom: Double
    let quantity: Double
    
    var variationColor: Color {
        if variation > 0 {
            return Color.green
        } else if variation == 0 {
            return Color.gray
        } else {
            return Color.red
        }
    }
    
    var variationFormatted: String {
        if variation > 0 {
            return "+\(variation)%"
        } else if variation == 0 {
            return "\(variation)%"
        } else {
            return "-\(abs(variation))%"
        }
    }
    
    var valueFormatted: String {
        let formattedValue = String(format: "%.2f", value)
        return "$\(formattedValue)"
    }
    
    var ctoPromFormatted: String {
        let formattedValue = String(format: "%.2f", cto_prom)
        return "$\(formattedValue)"
    }
    
    var quantityFormatted: String {
        return String(format: "%.2f", quantity)
    }
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: STOCK TITLE
            HStack{
                Text("\(title)")
                    .titleForeground()
                Spacer()
                Text(valueFormatted)
                    .titleForeground()
            }//: HSTACK
            
            // MARK: STOCK SYMBOL
            HStack{
                Text("\(symbol.uppercased())")
                    .bodyForeground()
                Spacer()
            }//: HSTACK
            
            // MARK: STOCK DATA
            HStack {
                Text("Cto Promedio \(ctoPromFormatted)")
                    .bodyForeground()
                Spacer()
                Text("\(quantityFormatted) titulos")
                    .bodyForeground()
                Spacer()
                Text("Hoy")
                    .bodyForeground()
                Text(variationFormatted)
                    .foregroundColor(variationColor)
                    .bodyForeground()
            }//: HSTACK
        }//: VSTACK
        .padding()
//        .background(Color.gray)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 1)
        )        
//        .frame(height: 60)
    }
}

struct StockItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        StockItemView(title: "aaaa", symbol: "aaa", value: 11.33, cto_prom: 10.0, quantity: 100)
            .previewLayout(.sizeThatFits)
    }
}
