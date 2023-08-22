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
    @State var isAdding: Bool = false
    @State var isSelling: Bool = false
    // MARK: BODY
    var body: some View {
        ZStack {
            VStack {
                Text(viewModel.stock?.name ?? "ddd")
                HStack {
                    Spacer()
                    Text("\(viewModel.stock?.quantity ?? 0)")
                    Spacer()
                    Text("\(viewModel.stock?.price_prom ?? 0)")
                    Spacer()
                }//: HSTACK
                Text("$\(viewModel.total)")
                List {
                    ForEach(viewModel.holds){
                        hold in
                        HoldItemView(
                            date: hold.date ?? Date(),
                            type: hold.type ?? "",
                            price: hold.price,
                            quantity: hold.quantity,
                            symbol: viewModel.stock?.symbol ?? "aaa")
                    }//: FOR
                }
                
                Spacer()
            }//: VSTACK
            .toolbar(content: {
                Button(action: {
                    
                }, label: {
                    Text("Editar")
                })
                Button(action: {
                    withAnimation(.easeIn(duration: 0.2)){
                        isAdding = true
                    }
                }, label: {
                    Image(systemName: "plus")
                })
                Button(action: {
                    withAnimation(.easeIn(duration: 0.2)){
                        isSelling = true
                    }
                }, label: {
                    Image(systemName: "minus")
                })
            })
            if viewModel.isLoading {
                LoadingView()
            }
            if isAdding {
                HoldModalFormView(viewModel: HoldModalFormViewModel(type: "buy", stock: viewModel.stock), isShowing: $isAdding)
                    .zIndex(2)
            }
            if isSelling{
                HoldModalFormView(viewModel: HoldModalFormViewModel(type: "sell", stock: viewModel.stock), isShowing: $isSelling)
                    .zIndex(3)
            }
        }//: ZSTACK
        .onChange(of: isAdding, perform: {
            value in
            if value == false {
                viewModel.refreshHold()
            }
        })
        .onChange(of: isSelling, perform: {
            value in
            if value == false {
                viewModel.refreshHold()
            }
        })
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
