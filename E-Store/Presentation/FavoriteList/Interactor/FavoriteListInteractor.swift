//
//  FavoriteListInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

protocol FavoriteListInteractor {
    func loadFavorites() -> [Product]
    func removeFavorite(product: Product)
}

class DefaultFavoriteListInteractor: FavoriteListInteractor {
    
    func loadFavorites() -> [Product] {
        return CoreDataService.shared.fetchFavorites()
    }
    
    func removeFavorite(product: Product) {
        
    }
}
