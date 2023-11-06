//
//  FavoriteListViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

class FavoriteListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadFavorites()
    }
    
    func setup(){
        title = "Favorites"
        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "product_cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadFavorites(){
        ApiService.shared.loadProducts(categoryId: 1) { [weak self] (result) in
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

}

// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! ProductViewCell
        
        let product = products[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: product.images.first ?? ""))
        cell.nameLabel.text = product.title
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = String(format: "$%.0f", product.price)

        
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
    
}
