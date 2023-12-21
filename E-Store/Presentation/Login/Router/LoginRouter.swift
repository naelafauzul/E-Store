//
//  LoginRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import UIKit

protocol LoginRouter {
    func create(completion: @escaping () -> Void) -> UIViewController
    func completeLogin()
}

class DefaultLoginRouter: LoginRouter {
    private var navigationController: UINavigationController!
    private var completion: (() -> Void)?
    
    func create(completion: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = DefaultLoginInteractor(apiService: ApiService.shared)
        let presenter = DefaultLoginPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.navigationController = navigationController
        self.completion = completion
        
        return navigationController
    }
    
    func completeLogin() {
        completion?()
    }
}
