//
//  CertificatesListViewModel.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import Foundation
import Combine

final class CertificatesListViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    @Published var certs : Certificates = []
    
    func fetchCertificatesData(page: Int, limit: Int) {
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
                                self.certs.append(certificate)
                            }
                        })
            .store(in: &cancellable)
    }
}
