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
        
        let viewControllers: [UIViewController] = [
            DefaultCategoryListRouter().create(),
            DefaultFavoriteListRouter().create(),
            DefaultProfileRouter().create()
        ]
        viewController.viewControllers = viewControllers
        
        return viewController
    }
}

