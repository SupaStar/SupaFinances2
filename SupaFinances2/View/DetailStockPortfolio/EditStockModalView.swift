//
//  EditStockModalView
//  SupaFinances2
//
//  Created by Obed Martinez on 28/08/23
//



import SwiftUI
import AlertToast

struct EditStockModalView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var app: Finances
    @Binding var isShowing: Bool
    @Binding var ctoProm: Double?
    @State var newCtoPromedio: String = ""
    @State var showToast: Bool = false
    @State var toastTitle: String = ""
    // MARK: BODY
    
    func save(){
        if let priceProm = Double(newCtoPromedio){
            self.ctoProm = priceProm
            withAnimation(.easeOut(duration: 0.3)){
                isShowing = false
            }
        }
        toastTitle = "El nuevo costo no tiene un formato valido."
        showToast.toggle()
    }
    
    var body: some View {
        ZStack {
            BlankPage()
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.3)){
                        isShowing = false
                    }
                }
            
            VStack(spacing: 20) {
                //1. Title
                Text("Editar costo promedio")
                    .titleForeground()
                
                //1. Body
                TextField("Nuevo costo promedio", text: $newCtoPromedio)
                    .keyboardType(.numberPad)
                
                //1. Footer
                Button(action: {
                    save()
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
        .toast(isPresenting: $showToast){
            AlertToast(displayMode: .banner(.pop), type: .regular , title: toastTitle)
        }//: TOAST
    }
}

struct EditStockModalView_Previews: PreviewProvider {
    static var previews: some View {
        EditStockModalView(isShowing: .constant(true), ctoProm: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
