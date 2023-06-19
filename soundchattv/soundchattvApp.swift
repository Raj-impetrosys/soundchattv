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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
