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
    @State var isEditing: Bool = false
    
    var pricePromVer: Double {
        var value = 0.0
        guard let priceProm = viewModel.stock?.price_prom else {
            return value
        }
        if !(priceProm.isNaN) {
            value = priceProm
        }
        return value
    }
    // MARK: BODY
    var body: some View {
        ZStack {
            VStack {
                HeaderPortfolioDetailView(
                    name: viewModel.stock?.name ?? "",
                    quantity: viewModel.stock?.quantity ?? 0,
                    priceProm: pricePromVer,
                    total: viewModel.total,
                    totalMarket: viewModel.totalMercado,
                    plusMinus: viewModel.plusMinus)
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
                    .onDelete(perform: viewModel.deleteHolds(offsets:))
                }//: LIST
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
                HoldModalFormView(viewModel: HoldModalFormViewModel(type: "buy", stock: viewModel.stock), isShowing: $isAdding, form: $viewModel.form)
                    .zIndex(2)
            }
            if isSelling{
                HoldModalFormView(viewModel: HoldModalFormViewModel(type: "sell", stock: viewModel.stock), isShowing: $isSelling, form: $viewModel.form)
                    .zIndex(3)
            }
        }//: ZSTACK
        .onChange(of: isAdding, perform: {
            value in
            if !value {
                viewModel.refreshHold()
            }
        })
        .onChange(of: isSelling, perform: {
            value in
            if !value {
                viewModel.refreshHold()
            }
        })
        .onChange(of: isEditing, perform: {
            value in
            if !value {
                
            }
        })
        .onChange(of: viewModel.form, perform: { value in
            viewModel.form = value
            viewModel.saveHold()
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
            .environmentObject(Finances())
    }
}
