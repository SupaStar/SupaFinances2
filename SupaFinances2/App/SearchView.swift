//
//  SearchView
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import SwiftUI

struct SearchView: View {
    // MARK: PROPERTIES
    private let stocks: [String] = []
    @State var search: String = ""
    // MARK: BODY
    var body: some View {
        VStack {
            SearchBar(searchTerm: $search)
            if stocks.isEmpty {
                EmptySearch()
            } else {
                
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
    searchBar.placeholder = "Type a song, artist, or album name..."
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
        SearchView()
    }
}
