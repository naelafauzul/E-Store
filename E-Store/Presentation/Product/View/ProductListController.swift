//
//  ProductListController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import UIKit

protocol ProductView: AnyObject {
    func reloadData()
}

class ProductListController: UIViewController, ProductView {
    
    #if DEBUG
    func getCoreDataDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding

         print("Core Data DB Path :: \(path ?? "Not found")")
    }
    #endif
    
    // MARK: - ProductListView Implementation
    func reloadData() {
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: ProductPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        #if DEBUG
        getCoreDataDBPath()
        #endif
        
        setup()
        loadProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        title = presenter.categoryName()
        tableView.register(UINib(nibName: "ProductViewCell", bundle: nil), forCellReuseIdentifier: "product_cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.addProduct()
    }
    
    func loadProducts() {
        presenter.loadProducts()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ProductListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "product_cell", for: indexPath) as! ProductViewCell
        
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.productImage(at: indexPath.row)))
        cell.nameLabel.text = presenter.productName(at: indexPath.row)
        cell.descriptionLabel.text = presenter.productDescription(at: indexPath.row)
        cell.priceLabel.text = presenter.productPrice(at: indexPath.row)
        
        let image = presenter.isFavorited(at: indexPath.row)
            ? UIImage(systemName: "star.fill")
            : UIImage(systemName: "star")
        cell.favoriteButton.setImage(image, for: .normal)
        
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ProductViewCellDelegate
extension ProductListController: ProductViewCellDelegate {
    func ProductViewCellFavoriteButtonTapped(_ cell: ProductViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            presenter.toogleFavorite(at: indexPath.row)
            let image = presenter.isFavorited(at: indexPath.row)
                ? UIImage(systemName: "star.fill")
                : UIImage(systemName: "star")
            cell.favoriteButton.setImage(image, for: .normal)
        }
    }
}
    

// MARK: - UITableViewDelegate
extension ProductListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectProduct(at: indexPath.row)
    }
}
