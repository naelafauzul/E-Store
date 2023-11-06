//
//  CategoryListPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import Foundation

protocol CategoryListPresenter {
    func loadCategories()
    func numberOfCategories() -> Int
    func categoryName(at index: Int) -> String
    func categoryImage(at index: Int) -> String
    func selectCategory(at index: Int)
}

class DefaultCategoryListPresenter: CategoryListPresenter {
    private weak var view: CategoryListView?
    private let interactor: CategoryListInteractor
    private let router: CategoryListRouter
    
    private var categories: [Category] = []
    
    init(view: CategoryListView? = nil, interactor: CategoryListInteractor, router: CategoryListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadCategories() {
        interactor.loadCategories { categories, error in
            self.categories = categories
            self.view?.reloadData()
            
        }
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func categoryName(at index: Int) -> String {
        return categories[index].name
    }
    
    func categoryImage(at index: Int) -> String {
        return categories[index].image
    }
    
    func selectCategory(at index: Int) {
        router.showProductList(category: categories[index])
    }
}
