//
//  StockView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI

struct StockItemView: View {
    // MARK: PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @State var variation: Double = -100.0
    
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
    // MARK: BODY
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: STOCK TITLE
            HStack{
                Text("Fibra Monterrey")
                    .titleForeground()
                Spacer()
                Text("$11.33")
                    .titleForeground()
            }//: HSTACK
            
            // MARK: STOCK SYMBOL
            HStack{
                Text("FMTY14")
                    .bodyForeground()
                Spacer()
            }//: HSTACK
            
            // MARK: STOCK DATA
            HStack {
                Text("Cto Promedio $11.54")
                    .bodyForeground()
                Spacer()
                Text("1000 titulos")
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
        .padding()
        
        
    }
}

struct StockItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        StockItemView()
            .previewLayout(.sizeThatFits)
    }
}
