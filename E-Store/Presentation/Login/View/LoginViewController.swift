//
//  LoginViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 07/10/23.
//

import UIKit

protocol LoginView: AnyObject {
    
}

class LoginViewController: UIViewController, LoginView {

    @IBOutlet weak var emailTitleLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        title = "Masuk"
        emailTitleLable.text = "Alamat Email"
        emailTextField.placeholder = "Email Anda"
        passwordTextField.placeholder = "Kata sandi"
        loginButton.setTitle("Masuk", for: UIControl.State.normal)
        loginButton.layer.cornerRadius = 4
        loginButton.layer.masksToBounds = true
        
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
