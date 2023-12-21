//
//  ProductDetailInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import Foundation

protocol ProductDetailInteractor {
    var product: Product { get }
}

class DefaultProductDetailInteractor: ProductDetailInteractor {
    internal let product: Product
    
    init(product: Product) {
        self.product = product
    }
}

