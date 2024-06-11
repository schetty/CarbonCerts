//
//  ContentView.swift
//  CarbonCerts
//
//  Created by Naomi on 06/06/2024.
//

import SwiftUI
import SwiftData

struct MainContentView: View {
    
    // MARK: - Properties
    @StateObject var certificatesListViewModel: CertificatesListViewModel
    @StateObject var favouritesListViewModel: FavouritesListViewModel = .init()
    @Environment(\.modelContext) private var context

    // Custom initializer sets up the view model using dependency injection and integrates it into the SwiftUI view using the StateObject property wrapper.
    init(certService: CertServiceProtocol = APIManager()) {
        // Initialize with a temporary context because context cannot be passed into the viewmodel before all other properties are initialized
        let temporaryContext = ModelContext(try! ModelContainer(for: Certificate.self))
        let viewModel = CertificatesListViewModel(certService: certService, context: temporaryContext)
        _certificatesListViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        TabView {
            CertificatesListView(context: context, viewModel: certificatesListViewModel)
                .toolbarRole(.editor)
                .tabItem {
                    Label {
                        Text(Constants.Strings.Home)
                    } icon: {
                        Image(systemName: "house.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24,
                                   height: 24)
                    }
                }
            
            FavouritesListView()
                .toolbarRole(.editor)
                .tabItem {
                    Label {
                        Text(Constants.Strings.Favs)
                    } icon: {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24,
                                   height: 24)
                    }
                }
        }
        .onAppear {
            // Update the view model's context after the view appears
            certificatesListViewModel.updateContext(context)
        }
    }
}
