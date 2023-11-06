//
//  CategoryListViewController.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 15/10/23.
//

import UIKit
import Kingfisher

//reference view contoller ke presenter by protocol
protocol CategoryListView: AnyObject {
    func reloadData()
}

class CategoryListViewController: UIViewController, CategoryListView {
    //MARK: CategoryListView Implementatios
    //akan dipanggil oleh presenter
    func reloadData() {
        tableView.reloadData()
    }
    
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    //reference untuk ke presenter
    var presenter: CategoryListPresenter!
    
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
    
    func loadCategories() {
        presenter.loadCategories()
        
    }
    
}

extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter.selectCategory(at: indexPath.row)
        
    }
}

extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "custom_category_cell", for: indexPath) as! CategoryViewCell
        
        cell.nameLabel.text = presenter.categoryName(at: indexPath.row)
        cell.thumbImageView.kf.setImage(with: URL(string: presenter.categoryImage(at: indexPath.row)))

        
        return cell
    }
    
    
}
