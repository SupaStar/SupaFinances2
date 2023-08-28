//
//  EditStockModalView
//  SupaFinances2
//
//  Created by Obed Martinez on 28/08/23
//



//import AlertToast
import SwiftUI

struct EditStockModalView: View {
    // MARK: PROPERTIES
    @Binding var isShowing: Bool
    @State var newCtoPromedio: String = ""
    // MARK: BODY
    var body: some View {
        ZStack {
            BlankPage()
            VStack(spacing: 20) {
                TextField("Nuevo costo promedio", text: $newCtoPromedio)
                Button(action: {
                    
                }, label: {
                    Text("Guardar")
                        .titleForeground()
                        .frame(width: 80, height: 20)
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                })
                .background(primaryColor)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            }//: VSTACK
            .onAppear(){
                newCtoPromedio = ""
            }
            .padding()
            .background()
            .cornerRadius(8)
            .padding(.horizontal)
        }//: ZSTACK
    }
}

struct EditStockModalView_Previews: PreviewProvider {
    static var previews: some View {
        EditStockModalView(isShowing: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
