//
//  CertificatesListView.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import SwiftUI
import SwiftData

struct CertificatesListView: View {
    
    // MARK: SwiftData related
    // must use modelContext in view's env to use 'Query'
    private var context: ModelContext
    @Query(sort: \Certificate.id, order: .forward) var allSavedCertificates: Certificates
    @ObservedObject var viewModel: CertificatesListViewModel
    
    init(context: ModelContext, viewModel: CertificatesListViewModel) {
        self.context = context
        self.viewModel = viewModel
    }
    
    var body: some View {
        let isTestingEnabled = CommandLine.arguments.contains("enable-testing")

        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.certs, id: \.self) { cert in
                        CertificateListCell(context: context, certificate: cert)
                            .background(Color.clear)
                            .listRowSeparator(.hidden)
                            .fixedSize(horizontal: true, vertical: false)
                    }.listRowBackground(Color.clear)
                        .padding(.top, 8)
                }
                .scrollContentBackground(.hidden)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.agreenateal.opacity(0.4), .white, .white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                )
                .navigationTitle(Constants.Strings.MainListTitle)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.agreenateal, for: .navigationBar)
                .toolbarColorScheme(.dark)
                .navigationBarTitleDisplayMode(.large)
                
                if isTestingEnabled {
                    Button {
                        viewModel.addSamples()
                    } label: {
                        Text(Constants.AccessibilityIdentifiers.AddSamplesButton)
                    }.accessibilityIdentifier(Constants.AccessibilityIdentifiers.AddSamplesButton)
                }
            }
            .onAppear {
                if !isTestingEnabled{
                    if allSavedCertificates.isEmpty {
                        Task {
                            await viewModel.loadCertificates(page: 1, limit: 10)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    } else {
                        viewModel.certs = allSavedCertificates
                    }
                }
            }
        }
    }
}

