//
//  FavoriteListRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import UIKit

protocol FavoriteListRouter {
    func create() -> UIViewController
    func showProduct(_ product: Product)
}

class DefaultFavoriteListRouter: FavoriteListRouter {
    private var navigationController: UINavigationController!
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "FavoriteListViewController") as! FavoriteListViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = DefaultFavoriteListInteractor()
        let presenter = DefaultFavoriteListPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.navigationController = navigationController
        return navigationController
    }
    
    func showProduct(_ product: Product) {
        
    }
}
