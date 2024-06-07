//
//  Certificate.swift
//  CarbonCerts
//
//  Created by Naomi on 06/06/2024.
//

import Foundation
import SwiftData

typealias Certificates = [Certificate]

@Model
// MARK: - Certificate

final class Certificate: Codable, Identifiable {
    @Attribute(.unique) let id: String?
    let originator: String?
    let originatorCountry: String?
    let owner: String?
    let ownerCountry: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case id, originator
        case originatorCountry = "originator-country"
        case owner
        case ownerCountry = "owner-country"
        case status
    }

    init(id: String?,
         originator: String?,
         originatorCountry: String?,
         owner: String?,
         ownerCountry: String?,
         status: String?) {
        self.id = id
        self.originator = originator
        self.originatorCountry = originatorCountry
        self.owner = owner
        self.ownerCountry = ownerCountry
        self.status = status
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        originator = try container.decodeIfPresent(String.self, forKey: .originator)
        originatorCountry = try container.decodeIfPresent(String.self, forKey: .originatorCountry)
        owner = try container.decodeIfPresent(String.self, forKey: .owner)
        ownerCountry = try container.decodeIfPresent(String.self, forKey: .ownerCountry)
        status = try container.decodeIfPresent(String.self, forKey: .status)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(originator, forKey: .originator)
        try container.encodeIfPresent(originatorCountry, forKey: .originatorCountry)
        try container.encodeIfPresent(owner, forKey: .owner)
        try container.encodeIfPresent(ownerCountry, forKey: .ownerCountry)
        try container.encodeIfPresent(status, forKey: .status)
    }
}

// MARK: - Hashable

extension Certificate: Hashable {
    static func == (lhs: Certificate, rhs: Certificate) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
