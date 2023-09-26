//
//  FooterFutureView
//  SupaFinances2
//
//  Created by Obed Martinez on 06/09/23
//



import SwiftUI

struct FooterFutureView: View {
    // MARK: PROPERTIES
    let desired: Double
    let have: Double
    let weekAmmount: Double
    let price: Double
    var restanting: Double {
        return self.desired - self.have
    }
    
    var timeRestanting: Double {
        return (price * restanting) / weekAmmount
    }
    
    func numberFormatter(ammount:Double) -> String {
        let numeroFormateado = String(format: "%.2f", ammount)
        return numeroFormateado
    }
    // MARK: BODY
    var body: some View {
        VStack(spacing:5) {
            Text("Monto mensual de aportacion: \(numberFormatter(ammount:weekAmmount))")
                .titleForeground()
            HStack {
                Text("Titulos deseados:")
                Text("\(numberFormatter(ammount:desired))")
                Spacer()
            }//: HSTACK
            HStack {
                Text("Titulos en posesion:")
                Text("\(numberFormatter(ammount:have))")
                Spacer()
            }//: HSTACK
            HStack {
                Spacer()
                Text("Diferencia:")
                Text("\(numberFormatter(ammount:restanting))")
            }//: HSTACK
            HStack {
                Spacer()
                Text("Tiempo aprox restante (meses):")
                Text("\(numberFormatter(ammount:timeRestanting))")
            }//: HSTACK
            HStack {
                Spacer()
                Text("Compra aprox por periodo:")
                Text("\(numberFormatter(ammount:weekAmmount / price))")
            }//: HSTACK
            Text("Diferencia en dinero: \(numberFormatter(ammount:restanting * price))")
                .titleForeground()
        }//: VSTACK
        .padding()
    }
}

struct FooterFutureView_Previews: PreviewProvider {
    static var previews: some View {
        FooterFutureView(desired: 100, have: 30, weekAmmount: 130, price: 11)
            .previewLayout(.sizeThatFits)
    }
}
