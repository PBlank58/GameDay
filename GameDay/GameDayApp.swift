//
//  GameDayApp.swift
//  GameDay
//
//  Created by Brett Pullyblank on 29/8/2023.
//

import SwiftUI

@main
struct GameDayApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            
            
       ContentView()
      .environment(\.managedObjectContext, persistenceController.container.viewContext)
      .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
