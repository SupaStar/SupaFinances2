//
//  ContentView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: PROPERTIES
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isLoading: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Stock.id, ascending: true)],
        animation: .default)
    private var stocks: FetchedResults<Stock>

    // MARK: BODY
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(stocks){ stock in
                        Text(stock.market_value!,formatter: marketValueFormatter)
                        Text(stock.name ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }//: LIST
                
            }//: NAV
            if (isLoading) {
                LoadingView()
            }
        }//: ZSTACK
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
