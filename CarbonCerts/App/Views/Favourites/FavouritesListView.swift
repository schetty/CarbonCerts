//
//  FavouritesListView.swift
//  CarbonCerts
//
//  Created by Naomi on 06/07/2024.
//

import SwiftUI
import SwiftData

struct FavouritesListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Certificate.id, order: .forward) private var certs: Certificates
    @ObservedObject var viewModel: FavouritesListViewModel
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationView {
            List {
            }.background(
                LinearGradient(gradient: Gradient(colors: [.teal.opacity(0.4), .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            )
        }
    }
}

#Preview {
    FavouritesListView(viewModel: FavouritesListViewModel())
        .modelContainer(for: Certificate.self, inMemory: true)
}
