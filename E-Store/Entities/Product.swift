//
//  Product.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 04/11/23.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category?
    let images: [String]
    
    //inisialisasi dari ProductData (Core Data)
    init(_ data: ProductData) {
        self.id = Int(data.productId)
        self.title = data.title ?? ""
        self.price = data.price
        self.description = data.desc ?? ""
        self.category = nil
        self.images = Array(data.images as? Set<String> ?? Set<String>())
    }
    
    init(title: String, price: Double, description: String, category: Category, images: [String]) {
        self.id = 0
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.images = images
    }
}

extension Product: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case categoryId
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        category = try container.decodeIfPresent(Category.self, forKey: .category)
        images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(Int(price), forKey: .price)
        try container.encode(description, forKey: .description)
        try container.encode(category?.id ?? 0, forKey: .categoryId) //hanya categoryId nya ang dikirim bukan category
        try container.encode(images, forKey: .images)
    }
}
