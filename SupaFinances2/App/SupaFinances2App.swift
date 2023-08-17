//
//  SupaFinances2App
//  SupaFinances2
//
//  Created by Obed Martinez on 16/08/23
//



import SwiftUI

@main
struct SupaFinances2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            IndexView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
