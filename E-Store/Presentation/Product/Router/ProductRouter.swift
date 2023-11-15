//
//  ProductRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/11/23.
//

import UIKit

protocol ProductRouter {
    func create(category: Category) -> UIViewController
    func showProduct(_ product: Product)
}

class DefaultProductRouter: ProductRouter {
    
    func create(category: Category) -> UIViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductListController") as! ProductListController
        
        let interactor = DefaultProductInteractor(category: category, apiService: ApiService.shared, coreDataService: CoreDataService.shared)
        let presenter = DefaultProductPresenter(view: viewController as ProductView, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        return viewController
    }
    
    func showProduct(_ product: Product) {
        
    }
}
    
 

