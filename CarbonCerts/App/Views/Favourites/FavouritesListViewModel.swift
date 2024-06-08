//
//  ContentView.swift
//  CarbonCerts
//
//  Created by Naomi on 06/06/2024.
//

import SwiftUI
import SwiftData

final class FavouritesListViewModel: ObservableObject {
    
    // MARK: - Initializer
    init(certs: Certificates = []) {
        loadFavorites()
    }
    
    func loadFavorites() {
    }
}
