//
//  BaseDAO.swift
//  EveryOne
//
//  Created by Zhao.bin on 16/1/12.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import CoreData

class BaseDAO: NSObject
{
    static let managedObjectModel : NSManagedObjectModel =
    {
        let modelURL = NSBundle.mainBundle().URLForResource("Model", withExtension: "momd")
    
        return NSManagedObjectModel(contentsOfURL: modelURL!)!
    }()
    
    static let persistentStoreCoordinator : NSPersistentStoreCoordinator =
    {
        let sqliteURL = NSURL.fileURLWithPath(kPathSQLITE)
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: BaseDAO.managedObjectModel)
        do
        {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: sqliteURL, options: nil)
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
        let moc = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        moc.persistentStoreCoordinator = BaseDAO.persistentStoreCoordinator

        return moc
    }()
    

}










