//
//  CarbonCertsApp.swift
//  CarbonCerts
//
//  Created by Naomi on 06/06/2024.
//

import SwiftUI
import SwiftData

@main
struct CarbonCertsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Certificate.self, isAutosaveEnabled: true)
    }
}
