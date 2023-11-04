//
//  Api.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 04/11/23.
//

import Foundation
import Moya

enum Api {
    case categories
    case products (Int)
}

extension Api: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.escuelajs.co")!
    }
    
    var path: String {
        switch self {
        case .categories:
            return "api/v1/categories"
        case .products(let categoryId):
            return "/api/v1/categories/\(categoryId)/products"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories:
            return .get
        case .products:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case.categories:
            return .requestPlain
        case .products:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
