//
//  FavoriteListViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 06/11/23.
//

import UIKit

import UIKit
import Kingfisher

protocol FavoriteListView: AnyObject {
    func reloadData()
}

class FavoriteListViewController: UIViewController, FavoriteListView {
    // MARK: CategoryListView Implementation
    func reloadData() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: FavoriteListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        loadFavorites()
    }
    
    func setup() {
        title = "Favorites"
        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "product_cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadFavorites() {
        presenter?.loadFavorites()
    }
}

// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else {
            return 0 // Or handle this case accordingly
        }
        return presenter.numberOfFavorites()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! ProductViewCell
        
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.productImage(at: indexPath.row)))
        cell.nameLabel.text = presenter.productName(at: indexPath.row)
        cell.descriptionLabel.text = presenter.productDescription(at: indexPath.row)
        cell.priceLabel.text = presenter.productPrice(at: indexPath.row)
        cell.favoriteButton.isHidden = true
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoriteListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter.selectFavorite(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Remove") { _, _, completion in
            self.presenter.removeFavorite(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        delete.image = UIImage(systemName: "trash")
        
        let actions = [
            delete
        ]
        
        return UISwipeActionsConfiguration(actions: actions)
    }
}
