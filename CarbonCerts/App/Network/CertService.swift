//
//  CertService.swift
//  CarbonCerts
//
//  Created by Naomi on 07/06/2024.
//

import Foundation
import Moya

enum Service {
    case getCerts(page: String, limit: String)
}

// MARK: - TargetType Protocol Implementation
extension Service: TargetType {
    var baseURL: URL { URL(string: "https://api-dev-v2.fieldmargin.com/tech-test)")! }
    
    var path: String {
        switch self {
        case .getCerts:
            return "/certificates/"
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
            return .requestParameters(parameters: ["page": page, "limit": limit], encoding: URLEncoding.queryString)
        }
    }
    
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data { Data(self.utf8) }
}
