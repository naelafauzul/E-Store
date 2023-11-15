//
//  ProductInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/11/23.
//

import Foundation

protocol ProductInteractor {
    func categoryName() -> String
    func loadProduct(completion: @escaping (Result<[Product], Error>) -> Void)
    func addFavorite(product: Product)
    func deleteFavorite(productId: Int)
    func isFavorited(productId: Int) -> Bool
}

class DefaultProductInteractor: ProductInteractor {
    private let category: Category
    private let apiService: ApiService
    private let coreDataService: CoreDataService
    
    init(category: Category, apiService: ApiService, coreDataService: CoreDataService) {
        self.category = category
        self.apiService = apiService
        self.coreDataService = coreDataService
    }
    
    func loadProduct(completion: @escaping (Result<[Product], Error>) -> Void) {
        apiService.loadProducts(categoryId: category.id) { (result) in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addFavorite(product: Product) {
        coreDataService.saveFavorite(product: product)
    }
    
    func deleteFavorite(productId: Int) {
        coreDataService.deleteFavorite(productId: productId)
    }
    
    func isFavorited(productId: Int) -> Bool {
        return coreDataService.isFavorited(productId: productId)
    }
    
    func categoryName() -> String {
        return category.name
    }
}

