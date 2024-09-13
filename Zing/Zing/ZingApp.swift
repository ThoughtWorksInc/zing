//
//  ZingApp.swift
//  Zing
//
//  Created by Andres Kievsky on 2/9/2024.
//

import SwiftUI
import SwiftData

@main
struct ZingApp: App {
    @NSApplicationDelegateAdaptor(ZingAppDelegate.self) var appDelegate

    var sharedModelContainer: ModelContainer = ZingModel().createModelContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .windowResizability(.contentSize)
        .modelContainer(sharedModelContainer)
        .environmentObject(ContentViewViewModel())
    }
}
