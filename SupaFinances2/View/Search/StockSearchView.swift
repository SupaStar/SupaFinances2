//
//  StockSearchView
//  SupaFinances2
//
//  Created by Obed Martinez on 18/08/23
//



import SwiftUI

struct StockSearchView: View {
    // MARK: PROPERTIES
    @State var isSaved: Bool
    let title: String
    let symbol: String
//    let value: Double
    
//    var valueFormatted: String {
//        return "$\(value)"
//    }
    // MARK: BODY
    var body: some View {
        HStack {
            Text(title.uppercased())
                .titleForeground()
            Spacer()
            Text(symbol.uppercased())
                .font(.system(.caption2, design: .rounded))
                .padding(.top, 5)
                .foregroundColor(textColor)
//            Text(valueFormatted)
//                .titleForeground()
            Image(systemName: isSaved ? "star.fill" : "star")
                .foregroundColor(isSaved ? Color.yellow : textColor)
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
//        .onTapGesture {
//            withAnimation(.linear(duration: 0.1)){
//                isSaved.toggle()
//            }
//        }
    }
}

struct StockSearchView_Previews: PreviewProvider {
    static var previews: some View {
//        StockSearchView(isSaved: true, title: "Aaa", symbol: "bbb", value: 1.0)
        StockSearchView(isSaved: true, title: "Aaa", symbol: "bbb")
            .previewLayout(.sizeThatFits)
    }
}
