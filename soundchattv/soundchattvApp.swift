//
//  soundchattvApp.swift
//  soundchattv
//
//  Created by RAJKUMAR on 01/05/23.
//

import SwiftUI

@main
struct soundchattvApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
