//
//  SearchView
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import SwiftUI

struct SearchView: View {
    // MARK: PROPERTIES
    @ObservedObject var viewModel: SearchViewModel
    @State var isSaved: Bool = false
    // MARK: BODY
    var body: some View {
        VStack {
            SearchBar(searchTerm: $viewModel.searchText)
            if viewModel.stocks.isEmpty {
                EmptySearch()
            } else {
                ScrollView(.vertical, showsIndicators: true){
                    ForEach(viewModel.stocks){ stock in
                        StockSearchView(
                            isSaved: stock.isSaved,
                            title: stock.instrument_name,
                            symbol: stock.symbol)
                        .onTapGesture {
                            viewModel.saveStock(stock: stock)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct EmptySearch: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Empieza la busqueda de tu accion.")
            Spacer()
        }
        .padding()
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Escribe el nombre de una accion o ETF..."
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
