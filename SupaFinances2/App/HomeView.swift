//
//  ContentView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI
import CoreData

struct HomeView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModel: HomeViewModel
    @StateObject var settings = Finances()
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
                                StockItemView(title: stock.name ?? "", symbol: stock.symbol ?? "", value: stock.value, cto_prom: stock.price_prom, quantity: stock.quantity)
                            })//: NAVLINK
                            
                        }//:FOR
                        .onDelete(perform: viewModel.deleteStock(offsets:))
                    }//: LIST
                    .padding(.horizontal, -20)
                    .padding(.vertical, -10)
                    Button(action: {
                        
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(textColor)
                            .offset(x: 0, y: -4)
                    })
                    .frame(width: 60, height: 60)
                    .background(primaryColor)
                    .clipShape(Circle())
                    .padding()
                    .contentShape(Circle())
                }//: VSTACK
            }//: ZSTACK
            
            if viewModel.isLoading{
                LoadingView()
            }
        }//: NAV
        .navigationTitle("Mis acciones")
        .onAppear(){
            viewModel.loadUsdValue()
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(isPreview: true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
