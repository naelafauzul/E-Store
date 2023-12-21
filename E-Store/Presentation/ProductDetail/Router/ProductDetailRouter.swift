//
//  ProductDetailRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import UIKit

protocol ProductDetailRouter {
    func create(product: Product) -> UIViewController
}

class DefaultProductDetailRouter: ProductDetailRouter {
    func create(product: Product) -> UIViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        
        let interactor = DefaultProductDetailInteractor(product: product)
        let presenter = DefaultProductDetailPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        return viewController
    }
}

