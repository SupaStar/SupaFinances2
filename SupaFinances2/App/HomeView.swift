//
//  ContentView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI
import CoreData
import AlertToast

struct HomeView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModel: HomeViewModel
    @StateObject var settings = Finances()
    
    func calculatePlusMinus(initialPrice: Double, price: Double) -> Double {
        let plusMinus = ((initialPrice - price) / initialPrice) * 100
        return plusMinus
    }
    // MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HeaderHomeView(ammount: viewModel.total )
                    
                    TitleSectionView(title: "Mis acciones")
                    List {
                        ForEach(viewModel.stocks){
                            stock in
                            NavigationLink(destination: DetailPortfolioStockView(viewModel: DetailPortfolioStockViewModel(stock: stock)), label: {
                                StockItemView(variation: calculatePlusMinus(initialPrice: stock.last_price, price: stock.value), title: stock.name ?? "", symbol: stock.symbol ?? "", value: stock.value, cto_prom: stock.price_prom, quantity: stock.quantity)
                            })//: NAVLINK
                            
                        }//:FOR
                        .onDelete(perform: viewModel.deleteStock(offsets:))
                    }//: LIST
                    .padding(.horizontal, -20)
                    .padding(.vertical, -10)
                    .refreshable {
                        viewModel.refreshValues()
                    }
//                    Button(action: {
//                        
//                    }, label: {
//                        Text("+")
//                            .font(.system(.largeTitle, design: .rounded))
//                            .foregroundColor(textColor)
//                            .offset(x: 0, y: -4)
//                    })
//                    .frame(width: 60, height: 60)
//                    .background(primaryColor)
//                    .clipShape(Circle())
//                    .padding()
//                    .contentShape(Circle())
                }//: VSTACK
            }//: ZSTACK
            .toast(isPresenting: $viewModel.showToast, alert: {
                AlertToast(displayMode: .banner(.pop),
                    type: viewModel.isToastError ? .error(Color.red) : .regular,
                    title: viewModel.toastError)
            })
            .onAppear(){
                viewModel.loadUsdValue()
                viewModel.loadStocks()
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }//: NAV
        .navigationTitle("Mis acciones")

    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(isPreview: true))
            .environmentObject(Finances())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
