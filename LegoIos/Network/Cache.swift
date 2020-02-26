//
//  CacheService.swift
//  LegoIos
//
//  Created by Mebius on 24/02/2020.
//  Copyright © 2020 Mebius. All rights reserved.
//

import Foundation
import CoreData

class Cache {
    private static var persistentContainer: NSPersistentContainer?

    var managedObjectContext: NSManagedObjectContext {
        if Cache.persistentContainer == nil {
            self.load()
        }
        return Cache.persistentContainer!.newBackgroundContext()
    }

    func load() {
        guard Cache.persistentContainer == nil else {
            return
        }
        let container = NSPersistentContainer(name: "LegoIos")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection
                 * when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("storeDescription: \(storeDescription)")
            }
        })
        Cache.persistentContainer = container
    }

    func save() {
        guard Cache.persistentContainer != nil else {
            print("Uninitialized cache. You need to call load function first")
            return
        }
        let context = Cache.persistentContainer!.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                // You should not use this function in a shipping application,
                // although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
