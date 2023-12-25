//
//  AppDelegate.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 07/10/23.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        checkFirstRun()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveContext()
    }
    
    //MARK: Helpers
    //cek aplikasi sedang berjalan untuk pertama kalinya pada perangkat tertentu atau tidak
    func checkFirstRun() {
        //cek apakah ada nilai yang disimpan dg kunci kFirstRunKey == nil
        if UserDefaults.standard.object(forKey: "kFirstRunKey") == nil {
            AccessTokenStore.shared.accessToken = nil
            //untuk menandai aplikasi pernah berjalan di perangkat
            UserDefaults.standard.setValue("Lorem Ipsum", forKey: "kFirstRunKey")
            UserDefaults.standard.synchronize()
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // MARK: Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EStore")
        container.loadPersistentStores { description, error in
            if let error = error {
                print(String(describing: error))
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                print(String(describing: error))
            }
        }
    }
}

