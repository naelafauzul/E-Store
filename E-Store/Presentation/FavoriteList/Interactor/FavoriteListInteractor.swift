//
//  FavoriteListInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

protocol FavoriteListInteractor {
    func loadFavorites() -> [Product]
    func removeFavorite(productId: Int)
}

class DefaultFavoriteListInteractor: FavoriteListInteractor {
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func loadFavorites() -> [Product] {
        return coreDataService.fetchFavorites()
    }
    
    func removeFavorite(productId: Int) {
        coreDataService.removeFavorite(productId: productId)
    }
}

