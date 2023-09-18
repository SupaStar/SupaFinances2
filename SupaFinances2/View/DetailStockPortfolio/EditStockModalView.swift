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
    @Binding var desiredTitles: Double?
    @Binding var weekAmmount: Double?
    @State var newCtoPromedio: String = ""
    @State var newDesiredTitles: String = ""
    @State var newAmmount: String = ""
    @State var showToast: Bool = false
    @State var toastTitle: String = ""
    // MARK: BODY
    
    func save(){
        if !newCtoPromedio.isEmpty {
            if let priceProm = Double(newCtoPromedio){
                self.ctoProm = priceProm
                withAnimation(.easeOut(duration: 0.3)){
                    isShowing = false
                }
            }
            toastTitle = "El nuevo costo no tiene un formato valido."
            showToast.toggle()
            return
        }
        if !newDesiredTitles.isEmpty && !newAmmount.isEmpty {
            if let desiredTitles = Double(newDesiredTitles),
               let newAmmount = Double(newAmmount) {
                self.desiredTitles = desiredTitles
                self.weekAmmount = newAmmount
                withAnimation(.easeOut(duration: 0.3)){
                    isShowing = false
                }
            }
            toastTitle = "Revisa el formato de numeros."
            showToast.toggle()
            return
        }

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
                    .keyboardType(.decimalPad)
                
                TextField("Titulos deseados", text: $newDesiredTitles)
                    .keyboardType(.decimalPad)
                
                TextField("Monto de aportaciones", text: $newAmmount)
                    .keyboardType(.decimalPad)
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
        EditStockModalView(isShowing: .constant(true), ctoProm: .constant(0), desiredTitles: .constant(10), weekAmmount: .constant(200))
            .previewLayout(.sizeThatFits)
    }
}
