//
//  MainViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

protocol MainView: AnyObject {
    func selectTab(index: Int)
}

class MainViewController: UITabBarController, MainView {
    
    var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 0..<((viewControllers ?? []).count) {
            let tabBarItem = viewControllers?[i].tabBarItem
            switch i {
            case 0:
                tabBarItem?.title = "Home"
                tabBarItem?.image = UIImage(systemName: "house")
                tabBarItem?.selectedImage = UIImage(systemName: "house.fill")
            case 1:
                tabBarItem?.title = "Favorites"
                tabBarItem?.image = UIImage(systemName: "star")
                tabBarItem?.selectedImage = UIImage(systemName: "star.fill")
            case 2:
                tabBarItem?.title = "Profile"
                tabBarItem?.image = UIImage(systemName: "person")
                tabBarItem?.selectedImage = UIImage(systemName: "person.fill")
            default:
                break
            }
        }
    }
    
    func selectTab(index: Int) {
        selectedIndex = index
    }
}

// MARK: - UITabBarControllerDelegate
extension MainViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let index = viewControllers?.firstIndex(of: viewController) {
            return presenter.shoudSelectTab(index: index)
        } else {
            return false
        }
    }
}
