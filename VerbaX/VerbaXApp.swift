//
//  VerbaXApp.swift
//  VerbaX
//
//  Created by shay moreno on 05/05/2025.
//

import SwiftUI

@main
struct VerbaXApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject private var launchScreenState = LaunchScreenStateManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .animation(.none, value: launchScreenState.state) // Remove any implicit animations

            if launchScreenState.state != .finished {
                LaunchScreenView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
