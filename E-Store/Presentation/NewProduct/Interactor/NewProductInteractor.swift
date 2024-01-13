//
//  NewProductInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 13/01/24.
//

import UIKit

protocol NewProductInteractor {
    func uploadImage(_ imageData: Data, completion: @escaping (Result<File, Error>) -> Void)
    func createProduct(_ product: Product, completion: @escaping (Result<Product, Error>) -> Void)
    func loadCategories(completion: @escaping ([Category], Error?) -> Void)
}

class DefaultNewProductInteractor: NewProductInteractor {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func uploadImage(_ imageData: Data, completion: @escaping (Result<File, Error>) -> Void) {
        apiService.uploadFile(data: imageData, completion: completion)
    }
    
    func createProduct(_ product: Product, completion: @escaping (Result<Product, Error>) -> Void) {
        apiService.createProduct(product: product, completion: completion)
    }
    
    func loadCategories(completion: @escaping ([Category], Error?) -> Void) {
        apiService.loadCategories(completion: completion)
    }
}

