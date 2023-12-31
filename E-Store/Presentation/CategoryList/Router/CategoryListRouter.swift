//
//  CategoryListRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 05/11/23.
//

import UIKit

protocol CategoryListRouter {
    func create() -> UIViewController
    func showProductList(category: Category)
}

class DefaultCategoryListRouter: CategoryListRouter {
    private var navigationController: UINavigationController!
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CategoryListViewController") as! CategoryListViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = DefaultCategoryListInteractor(apiService: ApiService.shared)
        let presenter = DefaultCategoryListPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.navigationController = navigationController
        return navigationController
    }
    
    func showProductList(category: Category) {
        let viewController = DefaultProductRouter().create(category: category)
        navigationController.pushViewController(viewController, animated: true)
    }
}
