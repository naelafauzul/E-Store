//
//  Category.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import Foundation

struct Category {
    let id: Int
    let name: String
    let image: String
}

extension Category: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}
