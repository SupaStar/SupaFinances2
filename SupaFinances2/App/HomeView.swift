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
    
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Stock.id, ascending: true)],
//        animation: .default)
//    private var stocks: FetchedResults<Stock>
    
    // MARK: BODY
    var body: some View {
        ZStack {
            VStack {
                HeaderHomeView()
                
                TitleSectionView(title: "Mis acciones")
                NavigationView {
                    List {
                        Text("\(viewModel.usdValue?.base ?? "")")
                        Text("\(viewModel.usdValue?.rates.MXN ?? 0)")
                        
                        ForEach(viewModel.stocks){
                            stock in
                            Text(stock.name ?? "")
                        }
                        ForEach(viewModel.holds) {
                            hold in
                            Text("\(hold.price )")
                        }
//                        ForEach(stocks){ stock in
//                            Text(stock.market_value!,formatter: marketValueFormatter)
//                            Text(stock.name ?? "")
//                        }
//                        .onDelete(perform: deleteItems)
                    }//: LIST
                }//: NAV
                .navigationTitle("Mis acciones")
                
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
                .contentShape(Circle())
                .padding()
            }//: VSTACK
            
            if viewModel.isLoading{
                LoadingView()
            }
        }//: ZSTACK
        .onAppear(){
            viewModel.loadUsdValue()
        }
    }
    
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(isPreview: true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
