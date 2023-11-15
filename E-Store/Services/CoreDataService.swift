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
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.context
    }
    
    func saveFavorite(product: Product) {
        let request = ProductData.fetchRequest()
        request.predicate = NSPredicate(format: "productId = \(product.id)")
        
        let productData: ProductData
        if let data = try? context.fetch(request).first {
            productData = data
        } else {
            productData = ProductData(context: context)
        }
        
        productData.productId = Int64(product.id)
        productData.title = product.title
        productData.desc = product.description
        productData.price = product.price
        productData.images = NSSet(array: product.images)
        productData.createdAt = Date()
 
        
        #if DEBUG
        try? context.save()
        #endif
    }
    func fetchFavorites()-> [Product] {
        let request = ProductData.fetchRequest()
        let datas = (try? context.fetch(request)) ?? []
        
        //cara cepat
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
    func deleteFavorite(productId: Int) {
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

