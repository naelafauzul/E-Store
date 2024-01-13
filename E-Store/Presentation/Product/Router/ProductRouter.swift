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
    func presentLogin(completion: @escaping () -> Void)
    func presentNewProduct(completion: @escaping () -> Void)
}

class DefaultProductRouter: ProductRouter {
    private var viewController: UIViewController!
    
    func create(category: Category) -> UIViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductListController") as! ProductListController
        
        let interactor = DefaultProductInteractor(category: category, apiService: ApiService.shared, coreDataService: CoreDataService.shared, accessTokenStore: .shared)
        let presenter = DefaultProductPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.viewController = viewController
        return viewController
    }
    
    func showProduct(_ product: Product) {
        let viewController = DefaultProductDetailRouter().create(product: product)
        self.viewController?.navigationController?
            .pushViewController(viewController, animated: true)
    }
    
    func presentLogin(completion: @escaping () -> Void) {
        let viewController = DefaultLoginRouter().create {
            self.viewController?.dismiss(animated: true, completion: completion)
        }
        self.viewController?.present(viewController, animated: true)
    }
    
    func presentNewProduct(completion: @escaping () -> Void) {
        let viewController = DefaultNewProductRouter().create {
            self.viewController?.dismiss(animated: true, completion: completion)
        }
        self.viewController?.present(viewController, animated: true)
    }
}
    
 

