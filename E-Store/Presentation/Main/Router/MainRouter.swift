//
//  MainRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

protocol MainRouter {
    func create() -> UIViewController
}

class DefaultMainRouter: MainRouter {
    func create() -> UIViewController {
        let viewController = MainViewController()
        
        let favoriteListViewController = UIStoryboard(name: "Favorite", bundle: nil)
            .instantiateViewController(withIdentifier: "FavoriteListViewController") as! FavoriteListViewController
        let favoriteListNavigationController = UINavigationController(rootViewController: favoriteListViewController)
        
        let viewControllers: [UIViewController] = [
            DefaultCategoryListRouter().create(),
            favoriteListNavigationController 
        ]
        
        viewController.viewControllers = viewControllers
        
        return viewController
    }
}
