//
//  DetailPortfolioStockView
//  SupaFinances2
//
//  Created by Obed Martinez on 19/08/23
//



import SwiftUI

struct DetailPortfolioStockView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModel: DetailPortfolioStockViewModel
    @StateObject var settings = Finances()
    
    // MARK: BODY
    var body: some View {
        ZStack{
            VStack {
                Text(viewModel.stock?.name ?? "ddd")
                Text("$\(viewModel.total)")
                ForEach(viewModel.holds){
                    hold in
                    HoldItemView(
                        date: hold.date ?? Date(),
                        type: hold.type ?? "",
                        price: hold.price,
                        quantity: hold.quantity,
                        symbol: viewModel.stock?.symbol ?? "aaa")
                }
                Spacer()
            }//: VSTACK
            .toolbar(content: {
                Button(action: {
                    
                }, label: {
                    Text("Editar")
                })
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus")
                })
            })
            if viewModel.isLoading {
                LoadingView()
            }
        }//: ZSTACK
        .onAppear() {
            withAnimation(.easeIn(duration: 0.1)){
                settings.isSubView = true
            }
        }
        .onDisappear(){
            withAnimation(.linear(duration: 0.1)){
                settings.isSubView = false
            }
        }
        .toolbar(settings.isSubView ? .hidden : .visible, for: .tabBar)
        
    }
}

struct DetailPortfolioStockView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPortfolioStockView(viewModel: DetailPortfolioStockViewModel(stock: nil))
    }
}
