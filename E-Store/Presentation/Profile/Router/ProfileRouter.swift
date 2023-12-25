//
//  ProfileRouter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import UIKit

protocol ProfileRouter {
    func create() -> UIViewController
    func presentLogin(completion: @escaping () -> Void)
}

class DefaultProfileRouter: ProfileRouter {
    private var navigationController: UINavigationController!
    
    func create() -> UIViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let interactor = DefaultProfileInteractor()
        let presenter = DefaultProfilePresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        
        self.navigationController = navigationController
        return navigationController
    }
    
    func presentLogin(completion: @escaping () -> Void) {
        let viewController = DefaultLoginRouter().create {
            self.navigationController?.dismiss(animated: true, completion: completion)
        }
        self.navigationController?.present(viewController, animated: true)
    }
}
