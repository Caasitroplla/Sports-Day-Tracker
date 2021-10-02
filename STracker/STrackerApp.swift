//
//  STrackerApp.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//

import SwiftUI

@main
struct STrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {	
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
