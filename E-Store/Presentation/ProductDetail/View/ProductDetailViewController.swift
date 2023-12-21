//
//  ProductDetailViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import UIKit

protocol ProductDetailView: AnyObject {
    
}

class ProductDetailViewController: UIViewController, ProductDetailView {
    
    var presenter: ProductDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    @IBAction func backToProduct(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        title = presenter.productName
    }
    
}
