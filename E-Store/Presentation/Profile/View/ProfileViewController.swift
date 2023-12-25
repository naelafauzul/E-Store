//
//  ProfileViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import UIKit

protocol ProfileView: AnyObject {
    func setStateLoggedIn()
    func setStateLoggedOut()
}

class ProfileViewController: UIViewController, ProfileView {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var presenter: ProfilePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        presenter.loadProfile()
    }
    
    func setup() {
        title = "Profile"
        setStateLoggedIn()
    }
    
    func setStateLoggedIn() {
        nameLabel.text = presenter.name ?? "Unknown"
        logoutButton.setTitle("Logout", for: .normal)
    }
    
    func setStateLoggedOut() {
        nameLabel.text = "Please Login"
        logoutButton.setTitle("Login", for: .normal)
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        presenter.logout()
    }
    
}
