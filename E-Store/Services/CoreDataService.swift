//
//  CoreDataService.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import CoreData
import UIKit

class CoreDataService {
    static var shared: CoreDataService = CoreDataService()
    private init(){}
    
    //Mendapatkan instance NSManagedObjectContext dari AppDelegate
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.context
    }
    
    func saveFavorite(product: Product) {
        //membuat fetch request untuk mencari data produk dengan predicate berdasarkan product.id
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId = \(product.id)")
        
        //membuat objek productData untuk diisi atau dibuat baru
        let productData: ProductData
        if let data = try? context.fetch(request).first {
            productData = data
        } else {
            productData = ProductData(context: context)
        }
        
        // Mengisi properti-properti objek ProductData dengan nilai dari objek Product
        productData.productId = Int64(product.id)
        productData.title = product.title
        productData.desc = product.description
        productData.price = product.price
        productData.images = NSSet(array: product.images)
        productData.createdAt = Date()
 
        // Menyimpan perubahan ke Core Data hanya dalam mode DEBUG
        #if DEBUG
        do {
            try context.save()
        } catch {
            print(String(describing: error))
        }
        #endif
            }
    
    //mengambil daftar produk favorit dari Core Data
    func fetchFavorites() -> [Product] {

        let request = ProductData.fetchRequest()
        let datas = (try? context.fetch(request)) ?? []
        
        //cara cepat untuk konversi ke tipe Product
        return datas.compactMap { Product($0)}
        
        //        //cara lama
        //        var products: [Product] = []
        //        datas.forEach { data in
        //            let product = Product(data)
        //            products.append(product)
        //        }
        //
        //        return products
        
    }
    
    func removeFavorite(productId: Int) {
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId = \(productId)")
        if let data = try? context.fetch(request).first {
            context.delete(data)
            
            #if DEBUG
            try? context.save()
            #endif
        }
    }
    
    func isFavorited(productId: Int) -> Bool {
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId = \(productId)")
        if let _ = try? context.fetch(request).first {
            return true
        } else {
            return false
        }
    }
}

