//
//  TitleSectionView
//  SupaFinances2
//
//  Created by Obed Martinez on 18/08/23
//



import SwiftUI

struct TitleSectionView: View {
    // MARK: PROPERTIES
    let title: String
    // MARK: BODY
    var body: some View {
        HStack{
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }//: HSTACK
        .padding()
    }
}

struct TitleSectionView_Previews: PreviewProvider {
    static var previews: some View {
        TitleSectionView(title: "Prueba")
    }
}
