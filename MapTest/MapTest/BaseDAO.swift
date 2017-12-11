//
//  BaseDAO.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/26.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import CoreData
class BaseDAO: NSObject
{
    static let managedObjectModel : NSManagedObjectModel =
        {
            let modelURL = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd")
            
            return NSManagedObjectModel(contentsOf: modelURL!)!
    }()
    
    static let persistentStoreCoordinator : NSPersistentStoreCoordinator =
        {
            let sqliteURL = URL(fileURLWithPath: kPathSQLITE)
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: BaseDAO.managedObjectModel)
            do
            {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: nil)
                print("Initial persistent store coordinator success")
            }catch
            {
                print("Initial persistent store coordinator failed - \(error)")
                abort()
            }
            return persistentStoreCoordinator
    }()
    
    static let mainMOC : NSManagedObjectContext =
        {
            let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            moc.persistentStoreCoordinator = BaseDAO.persistentStoreCoordinator
            
            return moc
    }()
    


}
