//
//  LoadingView
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI

struct LoadingView: View {
    // MARK: PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack{
            BlankPage()
            LoaderPage()
        }
    }
}
struct BlankPage: View {
    // MARK: PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    private var backgroundColor: Color {
        return isDarkMode ? Color.black : Color.gray
    }
    
    private var backgroundOpacity: Double {
        return isDarkMode ? 0.5 : 0.8
    }
    // MARK: BODY
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .edgesIgnoringSafeArea(.all)
    }
}
struct LoaderPage: View {
    // MARK: PROPERTIES
    // MARK: BODY
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                .scaleEffect(2)
                .padding(.top, 10)
            Text("Cargando")
        }//: VSTACK
        .padding(40)
        .background(
            .gray
        )
        .cornerRadius(8)
    }
}
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
