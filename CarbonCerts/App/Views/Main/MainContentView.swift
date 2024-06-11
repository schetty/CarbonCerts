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
    @StateObject var certificatesListViewModel: CertificatesListViewModel = .init()
    @StateObject var favouritesListViewModel: FavouritesListViewModel = .init()

    var body: some View {
        TabView {
            CertificatesListView(viewModel: certificatesListViewModel)
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
    }
}
