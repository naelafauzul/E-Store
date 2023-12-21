//
//  ProductDetailPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import Foundation

protocol ProductDetailPresenter {
    var productName: String { get }
    var productDescription: String { get }
    var productPrice: String { get }
    var priductImages: [String] { get }
}

class DefaultProductDetailPresenter: ProductDetailPresenter {
    private weak var view: ProductDetailView?
    private let interactor: ProductDetailInteractor
    private let router: ProductDetailRouter
    
    private var product: Product {
        return interactor.product
    }
    
    init(view: ProductDetailView, interactor: ProductDetailInteractor, router: ProductDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    var productName: String {
        return product.title
    }
    
    var productDescription: String {
        return product.description
    }
    
    var productPrice: String {
        return String(format: "%.0f", product.price)
    }
    
    var priductImages: [String] {
        return product.images
    }
    
}
