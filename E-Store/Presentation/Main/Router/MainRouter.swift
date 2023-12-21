//
//  MainRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

protocol MainRouter {
    func create() -> UIViewController
    func presentLogin(completion: @escaping () -> Void)
}

class DefaultMainRouter: MainRouter {
    private var viewController: UIViewController!
    
    func create() -> UIViewController {
        let viewController = MainViewController()
        
        let viewControllers: [UIViewController] = [
            DefaultCategoryListRouter().create(),
            DefaultFavoriteListRouter().create(),
            DefaultProfileRouter().create()
        ]
        viewController.viewControllers = viewControllers
        
        let interactor = DefaultMainInteractor()
        let presenter = DefaultMainPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.viewController = viewController
        return viewController
    }
    
    func presentLogin(completion: @escaping () -> Void) {
        let viewController = DefaultLoginRouter().create {
            self.viewController?.dismiss(animated: true, completion: completion)
        }
        self.viewController?.present(viewController, animated: true)
    }
}

