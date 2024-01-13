//
//  NewProductPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 13/01/24.
//

import UIKit

protocol NewProductPresenter {
    func uploadImage(_ image: UIImage)
    func createProduct(title: String, price: Double, description: String, categoryIndex: Int)
    func loadCategories()
    var images: [String] { get }
    var categories: [Category] { get }
}

class DefaultNewProductPresenter: NewProductPresenter {
    private weak var view: NewProductView?
    private let interactor: NewProductInteractor
    private let router: NewProductRouter
    
    var categories: [Category] = []
    var images: [String] = ["https://i.imgur.com/QkIa5tT.jpeg","https://i.imgur.com/jb5Yu0h.jpeg","https://i.imgur.com/UlxxXyG.jpeg"]
    
    init(view: NewProductView, interactor: NewProductInteractor, router: NewProductRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func uploadImage(_ image: UIImage) {
        let resizedImage = image.resizeImage(160, opaque: true)
        if let imageData = resizedImage.pngData() {
            interactor.uploadImage(imageData) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let file):
                    self.images.append(file.location)
                    self.view?.reloadData()
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    }

    
    func createProduct(title: String, price: Double, description: String, categoryIndex: Int) {
        let product = Product(title: title, price: price, description: description, category: categories[categoryIndex], images: images)
        interactor.createProduct(product) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success:
                self.router.completeCreateProduct()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func loadCategories() {
        interactor.loadCategories { categories, error in
            self.categories = categories
            self.view?.reloadData()
        }
    }
    
    
}


