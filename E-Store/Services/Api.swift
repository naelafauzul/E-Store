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
    case login(String, String) //email, password
    case profile
    case uploadFile(Data)
    case createProduct(Product)
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
        case .login:
            return "/api/v1/auth/login"
        case .profile:
            return "/api/v1/auth/profile"
        case .uploadFile:
            return "/api/v1/files/upload"
        case .createProduct:
            return "/api/v1/products/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories:
            return .get
        case .products:
            return .get
        case .login:
            return .post
        case .profile:
            return .get
        case .uploadFile:
            return .post
        case .createProduct:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case.categories:
            return .requestPlain
        case .products:
            return .requestPlain
        case .login(let username, let password):
            return .requestParameters(parameters: [
                "email": username,
                "password": password
            ],
            //parameter akan diencode sebagai JSON sebelum dikirim ke server.
            encoding: JSONEncoding.default //
            )
        case .profile:
            return .requestPlain
        case .uploadFile(let data):
            return .uploadMultipart([MultipartFormData(provider: .data(data), name: "file")])
        case .createProduct(let product):
            return .requestJSONEncodable(product)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
