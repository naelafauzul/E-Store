//
//  FavoriteListPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

protocol FavoriteListPresenter {
    func loadFavorites()
    func numberOfFavorites() -> Int
    func productName(at index: Int) -> String
    func productImage(at index: Int) -> String
    func productDescription(at index: Int) -> String
    func productPrice(at index: Int) -> String
    func removeFavorite(at index: Int)
    func selectFavorite(at index: Int)
}

class DefaultFavoriteListPresenter: FavoriteListPresenter {
    private weak var view: FavoriteListView?
    private let interactor: FavoriteListInteractor
    private let router: FavoriteListRouter
    
    private var favorites: [Product] = []
    
    init(view: FavoriteListView, interactor: FavoriteListInteractor, router: FavoriteListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadFavorites() {
        favorites = interactor.loadFavorites()
        view?.reloadData()
    }
    
    func numberOfFavorites() -> Int {
        return favorites.count
    }
    
    func productName(at index: Int) -> String {
        return favorites[index].title
    }
    
    func productImage(at index: Int) -> String {
        return favorites[index].images.first ?? ""
    }
    
    func productDescription(at index: Int) -> String {
        return favorites[index].description
    }
    
    func productPrice(at index: Int) -> String {
        return String(format: "%.0f", favorites[index].price)
    }
    
    func removeFavorite(at index: Int) {
        
    }
    
    func selectFavorite(at index: Int) {
        
    }
}

