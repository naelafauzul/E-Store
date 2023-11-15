//
//  Product.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 04/11/23.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category?
    let images: [String]
    
    //convert productdata menjadi product
    init(_ data: ProductData){
        self.id = Int(data.productId)
        self.title = data.title ?? ""
        self.price = data.price
        self.description = data.desc ?? ""
        self.category = nil
        self.images = Array(data.images as? Set<String> ?? Set<String>())
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.price = try container.decodeIfPresent(Double.self, forKey: .price) ?? 0.0
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.category = try container.decodeIfPresent(Category.self, forKey: .category) 
        self.images = try container.decodeIfPresent([String].self, forKey: .images) ?? []
        
        
    }
}
