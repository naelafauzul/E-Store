//
//  NewProductRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 13/01/24.
//


import UIKit

protocol NewProductRouter {
    func create(completion: @escaping () -> Void) -> UIViewController
    func completeCreateProduct()
}

class DefaultNewProductRouter: NewProductRouter {
    private var navigationController: UINavigationController!
    private var completion: (() -> Void)?
    
    func create(completion: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewProductViewController") as! NewProductViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = DefaultNewProductInteractor(apiService: ApiService.shared)
        let presenter = DefaultNewProductPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.navigationController = navigationController
        self.completion = completion
        
        return navigationController
    }
    
    func completeCreateProduct() {
        completion?()
    }
}
