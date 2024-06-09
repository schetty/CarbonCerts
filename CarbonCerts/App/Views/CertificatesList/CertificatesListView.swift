//
//  CertificatesListView.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import SwiftUI
import SwiftData

struct CertificatesListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Certificate.id, order: .forward) private var certs: Certificates
    @ObservedObject var viewModel: CertificatesListViewModel
    @State private var isLoading: Bool = true

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.certs, id: \.id, content: { cert in
                        Text("\(cert.id ?? "no id") - \(cert.originator ?? "no originator") ")
                            .padding(.horizontal, 20)
                    }).listRowBackground(Color.clear)
                }.onAppear {
                    viewModel.fetchCertificatesData(page: 1, limit: 10)
                }
                .scrollContentBackground(.hidden)
            }.navigationTitle(Constants.Strings.ListTitle)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.agreenateal, for: .navigationBar)
            .toolbarColorScheme(.dark)
            .navigationBarTitleDisplayMode(.large)
            .background(
                LinearGradient(gradient: Gradient(colors: [.agreenateal.opacity(0.4), .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            )
        }
    }
}

#Preview {
    CertificatesListView(viewModel: CertificatesListViewModel())
        .modelContainer(for: Certificate.self, inMemory: true)
}
