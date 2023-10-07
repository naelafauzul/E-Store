//
//  LoginViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 07/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTitleLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        titleLabel.text = "Masuk"
        emailTitleLable.text = "Alamat Email"
        emailTextField.placeholder = "Email Anda"
        passwordTextField.placeholder = "Kata sandi"
        loginButton.setTitle("Masuk", for: UIControl.State.normal)
        loginButton.layer.cornerRadius = 4
        loginButton.layer.masksToBounds = true
        
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("email: \(String(describing: emailTextField.text))")
        print("password: \(String(describing: passwordTextField.text))")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
