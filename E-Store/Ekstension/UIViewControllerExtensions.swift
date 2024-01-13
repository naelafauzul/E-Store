//
//  UIViewControllerExtensions.swift
//  E Store
//
//  Created by Naela Fauzul Muna on 13/01/24.
//

import UIKit

extension UIViewController {
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
