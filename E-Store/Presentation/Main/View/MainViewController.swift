//
//  MainViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0..<((viewControllers ?? []).count){
            let tabBarItem = viewControllers? [i].tabBarItem
            switch i {
            case 0:
                tabBarItem?.title = "Home"
                tabBarItem?.image = UIImage(systemName: "house")
                tabBarItem?.selectedImage = UIImage(systemName: "house.fill")
                
            case 1:
                tabBarItem?.title = "Favorites"
                tabBarItem?.image = UIImage(systemName: "star")
                tabBarItem?.selectedImage = UIImage(systemName: "star.fill")
            default:
                break
            }
        }
        
    }
}
