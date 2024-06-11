//
//  CertService.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import SwiftUI
import Combine
import CombineMoya
import Moya

//protocol APIService {
//    func fetchCertificates(page: String, limit: String) -> AnyPublisher<Certificates, ErrorModel>
//}

struct APIManager {
    
    // MARK: - API Constants
    // Keep API constants within the service file and separate from global string constants for the rest of the app.

    struct APIConstants {
        // Base URL + the API key that is sent with the headers
        static let APIKey = "FIELDMARGIN-TECH-TEST"
        static let APIBase = "https://api-dev-v2.fieldmargin.com/tech-test"
        
        // Endpoint for fetching carbon certificates
        struct Endpoints {
            static let Certificates = "/certificates"
        }
        
        // Params that will be attached to query string in GET request
        struct ParameterKeys {
            static let Page = "page"
            static let Limit = "limit"
        }
    }
    
    static private var cancellables = Set<AnyCancellable>()
    
    static func fetchCertificates(page: String, limit: String) -> AnyPublisher<Certificates, ErrorModel> {
        Future<Certificates, ErrorModel> { promise in
            let provider = MoyaProvider<CertService>()
            provider.requestPublisher(.getCerts(page: page, limit: limit))
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error) :
                        print("couldn't retrieve certificates : " + error.localizedDescription)
                    case .finished :
                        print("succcessfully retrieved certificates")
                    }
                }, receiveValue: { response in
                    guard let result = try? JSONDecoder().decode(Certificates.self, from: response.data) else {
                        return
                    }
                    promise(.success(result))
                })
                .store(in: &cancellables)
            
        }.eraseToAnyPublisher()
    }
}

enum CertService {
    case getCerts(page: String, limit: String)
}

// MARK: - TargetType Protocol Implementation
extension CertService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: APIManager.APIConstants.APIBase) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getCerts:
            return APIManager.APIConstants.Endpoints.Certificates
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCerts:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCerts(let page, let limit): // Always sends page and limit params in URL, regardless of which HTTP method is used
            let params = [APIManager.APIConstants.ParameterKeys.Page: page,
                          APIManager.APIConstants.ParameterKeys.Limit: limit]
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json",
                "api-key": APIManager.APIConstants.APIKey]
    }
    
    var sampleData: Data {
        return Data()
    }
}


// MARK: - Error
struct ErrorModel: Codable, Error {
    var code : String = ""
    var message : String? = ""
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data { Data(self.utf8) }
}
