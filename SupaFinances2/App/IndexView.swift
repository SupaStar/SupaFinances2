//
//  IndexView
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import SwiftUI

struct IndexView: View {
    // MARK: PROPERTIES

    // MARK: BODY
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(isPreview: false))
                .tabItem{
                    Label("Inicio", systemImage: "house.fill")
                }
            SearchView(viewModel: SearchViewModel())
                .tabItem{
                    Label("Prueba", systemImage: "magnifyingglass")
                }
        }//: TABS
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
    }
}
