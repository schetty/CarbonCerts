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
    
    /// Fetches certificates from the remote API.
        /// - Parameters:
        ///   - page: The page number to fetch.
        ///   - limit: The number of certificates per page.
    func loadCertificates(page: Int, limit: Int, from context: ModelContext) async {
        APIManager.fetchCertificates(page: "\(page)", limit: "\(limit)")
            .sink(receiveCompletion: { result in
            }, receiveValue: { certs in
                for cert in certs {
                    let certificate = Certificate(id: cert.id,
                                                  originator: cert.originator,
                                                  originatorCountry: cert.originatorCountry,
                                                  owner: cert.owner,
                                                  ownerCountry: cert.ownerCountry,
                                                  status: cert.status)
                    self.saveCertificate(certificate, from: context)
                    self.certs.append(certificate)
                }
            })
            .store(in: &cancellable)
    }
    
    private func saveCertificate(_ cert: Certificate, from context: ModelContext) {
        context.insert(cert)
    }
    
}
