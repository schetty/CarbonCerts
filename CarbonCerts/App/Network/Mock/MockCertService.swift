//
//  MockCertService.swift
//  CarbonCerts
//
//  Created by Naomi on 11/06/2024.
//

import Combine

class MockCertService: CertServiceProtocol {
    func fetchCertificates(page: String, limit: String) -> AnyPublisher<Certificates, ErrorModel> {
        let mockCertificates = [
            Certificate(id: "1", originator: "Originator A", originatorCountry: "Country A", owner: "Owner A", ownerCountry: "Country A", status: "Active")
        ]
        return Just(mockCertificates)
            .setFailureType(to: ErrorModel.self)
            .eraseToAnyPublisher()
    }
}
