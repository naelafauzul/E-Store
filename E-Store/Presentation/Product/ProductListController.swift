//
//  ProductListController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import UIKit

class ProductListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var category: Category!
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        title = category.name
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadProducts() {
        ApiService.shared.loadProducts(categoryId: category.id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ProductListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! ProductViewCell
        
        let product = products[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: product.images.first ?? ""))
        cell.nameLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = String(format: "%.0f", product.price)
        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductListController: UITableViewDelegate {
    
}
