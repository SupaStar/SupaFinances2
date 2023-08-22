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
    
    // MARK: FUNCS
    func closeModal(){
        withAnimation(.easeOut(duration: 0.2)){
            isShowing = false
        }
    }
    
    // MARK: BODY
    var body: some View {
        ZStack {
            BlankPage()
                .onTapGesture {
                    closeModal()
                }
            VStack(spacing: 10){
                TextField("Titulos comprados", text: $viewModel.quantityS)
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
            .padding()
            .background()
            .cornerRadius(8)
            .padding()
        }//: ZSTACK
    }
}

struct HoldModalFormView_Previews: PreviewProvider {
    static var previews: some View {
        HoldModalFormView(viewModel: HoldModalFormViewModel(type: "Buy", stock: nil), isShowing: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
