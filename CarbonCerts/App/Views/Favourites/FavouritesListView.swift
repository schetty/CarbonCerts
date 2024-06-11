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
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(certs, id: \.self) { cert in
                        if cert.isFavorited {
                            CertificateListCell(context: context, certificate: cert)
                                .background(Color.clear)
                                .listRowSeparator(.hidden)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }.listRowBackground(Color.clear)
                        .padding(.top, 8)
                }
                .scrollContentBackground(.hidden)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.agreenateal.opacity(0.4), .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                )
                .navigationTitle(Constants.Strings.FavoritesListTitle)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.agreenateal, for: .navigationBar)
                .toolbarColorScheme(.dark)
            }
        }
    }
}

#Preview {
    FavouritesListView()
        .modelContainer(for: Certificate.self, inMemory: true)
}
