//
//  StockSearchView
//  SupaFinances2
//
//  Created by Obed Martinez on 18/08/23
//



import SwiftUI

struct StockSearchView: View {
    // MARK: PROPERTIES
    let title: String = "danhos"
    let symbol: String = "danh"
    let value: Double = 20.03
    
    var valueFormatted: String {
        return "$\(value)"
    }
    // MARK: BODY
    var body: some View {
        HStack {
            Text(title.uppercased())
                .titleForeground()
            Text(symbol.uppercased())
                .font(.system(.caption2, design: .rounded))
                .padding(.top, 5)
                .foregroundColor(textColor)
            Spacer()
            Text(valueFormatted)
                .titleForeground()
            Image(systemName: "chevron.right")
                .titleForeground()
        }//: HSTACK
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.black, lineWidth: 0.1)
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: Color(UIColor.lightGray), radius: 0.4, x: 3, y: 3)
        )
        .padding()
    }
}

struct StockSearchView_Previews: PreviewProvider {
    static var previews: some View {
        StockSearchView()
            .previewLayout(.sizeThatFits)
    }
}
