//
//  File.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 12/01/24.
//

import Foundation

struct File: Decodable {
    let originalName: String
    let fileName: String
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case originalName = "originalname"
        case fileName = "filename"
        case location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName) ?? ""
        self.fileName = try container.decodeIfPresent(String.self, forKey: .fileName) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
    }
}
