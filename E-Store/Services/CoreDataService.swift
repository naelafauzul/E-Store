//
//  CoreDataService.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation
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
        productData.images = NSArray(array: product.images)
        
        #if DEBUG
        try? context.save()
        #endif
    }
    
}
