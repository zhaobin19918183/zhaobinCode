//
//  WeatherDAO.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/18.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit
import CoreData

class WeatherDAO: BaseDAO {

    //MARK: - Create
    static func createEntityWith(InitialClosure closure : (newEntity : WeatherEntity )->() ) -> Bool
    {
        let entity = NSEntityDescription.insertNewObjectForEntityForName(self.entityName(), inManagedObjectContext: BaseDAO.mainMOC) as! WeatherEntity
        
        closure(newEntity: entity)
        
        return self.save()
    }
    
    //MARK: - Update
    static func updateEntityWith(Entity entity : WeatherEntity) -> Bool
    {
        return self.save()
    }
    
    //MARK: - Delete
    static func deleteEntityWith(Entity entity : WeatherEntity) -> Bool
    {
        BaseDAO.mainMOC.deleteObject(entity)
        return self.save()
    }
    
    //MARK: - Retrive
    static func retriveEntityWith(ID identification : String) -> [WeatherEntity]
    {
        let request = NSFetchRequest(entityName: self.entityName())
        let searchEntity = NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: BaseDAO.mainMOC)
        request.entity = searchEntity
        let predicate = NSPredicate(format: "identification == %@", identification)
        request.predicate = predicate
        do
        {
            let resultArray = try BaseDAO.mainMOC.executeFetchRequest(request)
            return resultArray as! [WeatherEntity]
        }catch
        {
            return [WeatherEntity]()
        }
    }
    
    static  func createNewPassWordData(dicData:NSMutableDictionary)
    {

        let success = WeatherDAO.createEntityWith { (newEntity:WeatherEntity) -> () in
            
            let realtimedata : NSData = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("realtime")!)
            let lifedata : NSData = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("life")!)
            let weatherdata : NSData = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("weather")!)
            let pmdata : NSData = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("pm25")!) 
            
            newEntity.realtime = realtimedata 
            newEntity.life = lifedata
            newEntity.weather = weatherdata
            newEntity.pm25 = pmdata
            
        }
        if success == true
        {
            print("保存成功")
            //            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        else
        {
            print("保存失败")
            
        }
        
    }
    static  func  SearchCoreDataEntity() -> NSMutableArray    {
        
        let managedContext = BaseDAO.mainMOC
        let fetchRqeust = NSFetchRequest(entityName: "WeatherEntity")
        let fetcheResults : [NSManagedObject]=try!managedContext.executeFetchRequest(fetchRqeust) as AnyObject as! [NSManagedObject]
        
        let coredataArr = (fetcheResults as AnyObject as?[NSMutableArray])!
        
        if  fetcheResults.count > 0 {
            
            return [coredataArr]
        }else{
            return [coredataArr]
        }
        //  return [coredataArr]
    }

    static func save() -> Bool
    {
        if BaseDAO.mainMOC.hasChanges
        {
            do
            {
                try BaseDAO.mainMOC.save()
            }
            catch
            {
                return false
            }
            
            return true
        }else
        {
            return false
        }
    }
    
    static func entityName() -> String
    {
        return "WeatherEntity"
    }
}
