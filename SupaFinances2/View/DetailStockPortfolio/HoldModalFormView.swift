//
//  HoldModalFormView
//  SupaFinances2
//
//  Created by Obed Martinez on 21/08/23
//



import SwiftUI

struct HoldModalFormView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModel: HoldModalFormViewModel
    @Binding var isShowing: Bool
    @Binding var form: HoldViewModel?
    // MARK: FUNCS
    func closeModal(){
        withAnimation(.easeOut(duration: 0.2)){
            isShowing = false
        }
    }
    
    func save(hold: HoldViewModel){
        self.form = hold
        closeModal()
    }
    
    // MARK: BODY
    var body: some View {
        ZStack {
            BlankPage()
                .onTapGesture {
                    closeModal()
                }
            VStack(spacing: 10){
                Text(viewModel.type.lowercased() == "buy" ? "Compra" : "Venta")
                TextField("Numero de titulos", text: $viewModel.quantityS)
                    .keyboardType(.numberPad)
                
                TextField("Precio por titulo", text: $viewModel.priceS)
                    .keyboardType(.numberPad)
                
                DatePicker(selection: $viewModel.dateHold, displayedComponents: .date){
                    Label("Hold date", systemImage: "calendar.badge.plus")
                }
                
                Button(action: {
                    viewModel.save()
                }, label: {
                    Text("Guardar")
                        .titleForeground()
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                })
                .background(primaryColor)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
            }//: VSTACK
            .onAppear(){
                viewModel.saved = { value in
                    save(hold: value)
                }
            }
            .padding()
            .background()
            .cornerRadius(8)
            .padding()
        }//: ZSTACK
    }
}

struct HoldModalFormView_Previews: PreviewProvider {
    static var previews: some View {
        HoldModalFormView(viewModel: HoldModalFormViewModel(type: "Buy", stock: nil), isShowing: .constant(false), form: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
