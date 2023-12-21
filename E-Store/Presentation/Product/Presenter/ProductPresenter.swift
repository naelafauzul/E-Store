//
//  ProductPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/11/23.
//

import Foundation

protocol ProductPresenter {
    func categoryName() -> String
    func loadProducts()
    func numberOfProducts() -> Int
    func productName(at index: Int) -> String
    func productImage(at index: Int) -> String
    func productDescription(at index: Int) -> String
    func productPrice(at index: Int) -> String
    func selectProduct(at index: Int)
    func toogleFavorite(at index: Int)
    func isFavorited(at index: Int) -> Bool
    func addProduct()
}


class DefaultProductPresenter: ProductPresenter {
    private weak var view: ProductView?
    private let interactor: ProductInteractor
    private let router: ProductRouter
    
    private var products: [Product] = []
    
    init(view: ProductView, interactor: ProductInteractor, router: ProductRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func toogleFavorite(at index: Int) {
        let product = products[index]
        if isFavorited(at: index) {
            interactor.removeFavorite(productId: product.id)
        } else {
            interactor.addFavorite(product: product)
        }
    }
    
    func isFavorited(at index: Int) -> Bool {
        let product = products[index]
        return interactor.isFavorited(productId: product.id)
    }
    
    func categoryName() -> String {
        return interactor.categoryName()
    }
    
    func loadProducts() {
        interactor.loadProduct(completion: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.view?.reloadData()
            case .failure(_):
                break
            }
        })
    }
    
    func numberOfProducts() -> Int {
        return products.count
    }
    
    func productName(at index: Int) -> String {
        return products[index].title
    }
    
    func productImage(at index: Int) -> String {
        return products[index].images.first ?? ""
    }
    
    func productDescription(at index: Int) -> String {
        return products[index].description
    }
    
    func productPrice(at index: Int) -> String {
        return String(format: "%.0f", products[index].price)
    }
    
    func selectProduct(at index: Int) {
        router.showProduct(products[index])
    }
    
    func addProduct() {
        if interactor.canAddProduct() {
            
        } else {
            router.presentLogin {
                self.addProduct()
            }
        }
    }
    
    
}
