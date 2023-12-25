//
//  Profile.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 24/12/23.
//

import Foundation

struct Profile: Codable {
    let id: Int
    let email: String
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatar = try container.decode(String.self, forKey: .avatar)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.avatar, forKey: .avatar)
    }
}
