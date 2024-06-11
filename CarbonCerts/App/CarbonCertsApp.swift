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
    
    let modelContainer: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            MainContentView(certService: APIManager())
        }.modelContainer(modelContainer)
    }
    
    init() {
        var inMemory = false
        
#if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            inMemory = true
        }
#endif
        
        do {
            let configuration = ModelConfiguration(for: Certificate.self, isStoredInMemoryOnly: inMemory)
            modelContainer = try ModelContainer(for: Certificate.self, configurations: configuration)
        } catch {
            fatalError("Failed to load model container.")
        }
    }
}

