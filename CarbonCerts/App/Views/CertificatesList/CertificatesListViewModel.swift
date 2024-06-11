//
//  CertificatesListViewModel.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import Combine
import SwiftUI
import SwiftData

@MainActor
final class CertificatesListViewModel: ObservableObject {
    
    // MARK: - Swift Data
    
    var cancellable = Set<AnyCancellable>()
    // Published variable that is an array of T: Certificate that is populated local caching from SwiftData if present, otherwise populated upon the fetchCertificates API Call
    @Published var certs: Certificates = []
    private let certService: CertServiceProtocol
    
    private var context: ModelContext
    
    init(certService: CertServiceProtocol, context: ModelContext) {
        self.certService = certService
        self.context = context
    }
    
    func updateContext(_ newContext: ModelContext) {
        self.context = newContext
    }
    
    /// Fetches certificates from the remote API.
    /// - Parameters:
    ///   - page: The page number to fetch.
    ///   - limit: The number of certificates per page.
    func loadCertificates(page: Int, limit: Int) async {
        certService.fetchCertificates(page: "\(page)", limit: "\(limit)")
            .sink(receiveCompletion: { result in
            }, receiveValue: { certs in
                for cert in certs {
                    let certificate = Certificate(id: cert.id,
                                                  originator: cert.originator,
                                                  originatorCountry: cert.originatorCountry,
                                                  owner: cert.owner,
                                                  ownerCountry: cert.ownerCountry,
                                                  status: cert.status)
                    self.saveCertificate(certificate)
                    self.certs.append(certificate)
                }
            })
            .store(in: &cancellable)
    }
    
    /// Saves the passed certificate to the provided model context.
    /// - Parameters:
    ///   - cert: The certificate object to save.
    private func saveCertificate(_ cert: Certificate) {
        context.insert(cert)
        try? context.save()
    }
}

extension CertificatesListViewModel {
    
    func addSamples() {
        let sample1 = Certificate(id: "555wnfndjjf", originator: "Originator 1", originatorCountry: "Tanzania", owner: "Random", ownerCountry: "Zanzibar", status: "Active")
        let sample2 = Certificate(id: "gjsdrugsd4452345", originator: "Originator 2", originatorCountry: "Kenya", owner: "Random", ownerCountry: "Lamu", status: "Retired")
        let sample3 = Certificate(id: "934w8937947239hkj", originator: "Originator 3", originatorCountry: "Botswana", owner: "Random", ownerCountry: "Gaborone", status: "Active")
        
        context.insert(sample1)
        context.insert(sample2)
        context.insert(sample3)
        try? context.save()
        fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<Certificate>(sortBy: [SortDescriptor(\.id)])
            certs = try context.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
}
