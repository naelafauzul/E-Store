//
//  CategoryListViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import UIKit
import Kingfisher

class CategoryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var CategoryList: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        title = "Category List"
    }
    
    func loadCategories(){
        ApiService.shared.loadCategories { categories, error in
            if let error = error {
                let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            } else {
                self.CategoryList = categories
                self.tableView.reloadData()
            }
        }
    }
}

extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = CategoryList[indexPath.row]
        
        //memanggil product list controller
        let storyboard = UIStoryboard(name: "Product", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProductListController") as! ProductListController
        viewController.category = category
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_category_cell", for: indexPath) as! CategoryViewCell
        
        let category = CategoryList[indexPath.row]
        cell.nameLabel.text = category.name
        cell.thumbImageView.kf.setImage(with: URL(string: category.image))
//        ApiService.shared.loadImage(urlString: category.image) { image in
//            cell.thumbImageView.image = image
//        }
        
        return cell
    }
    
    
}
