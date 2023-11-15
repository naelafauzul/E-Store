//
//  ProfileViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import UIKit

protocol ProfileView: AnyObject {
    
}

class ProfileViewController: UIViewController, ProfileView {

    var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        title = "Profile"
    }
}
