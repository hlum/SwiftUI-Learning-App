//
//  Crypto_TrackerApp.swift
//  Crypto Tracker
//
//  Created by Hlwan Aung Phyo on 2024/07/23.
//

import SwiftUI

@main
struct Crypto_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
