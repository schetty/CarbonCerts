//
//  ContentView.swift
//  CarbonCerts
//
//  Created by Naomi on 06/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Certificate.id, order: .forward) private var certs: Certificates
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(certs) { cert in
                    NavigationLink {
                        Text("Certificate data here")
                    } label: {
                        Text("Cert info here")
                    }
                }
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
            }
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Certificate.self, inMemory: true)
}
