//
//  IndexView
//  SupaFinances2
//
//  Created by Obed Martinez on 17/08/23
//



import SwiftUI

struct IndexView: View {
    // MARK: PROPERTIES
    @EnvironmentObject private var finances: Finances

    // MARK: BODY
    var body: some View {
        ZStack {
            TabView {
                HomeView(viewModel: HomeViewModel(isPreview: false))
                    .tabItem{
                        Label("Inicio", systemImage: "house.fill")
                    }
            }//: TABS
            if finances.isLoading {
                LoadingView()
            }
        }//: ZSTACK
    }
}

struct IndexView_Previews: PreviewProvider {
    static var previews: some View {
        IndexView()
            .environmentObject(Finances())
    }
}
