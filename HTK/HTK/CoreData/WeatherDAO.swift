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
        var  model =  WeatherModel.convertFrom(entity)
        model.life     = entity.life
        model.realtime = entity.realtime
        model.pm25     = entity.life
        model.weather  = entity.life
        return self.save()
    }
    
    //MARK: - Delete
    static func deleteEntityWith(Entity entity : WeatherEntity) -> Bool
    {
        BaseDAO.mainMOC.deleteObject(entity)
        return self.save()
    }
    //MARK: - Retrive 按条件搜索数据
    static func retriveEntityWith(ID identification : String) -> [WeatherEntity]
    {
        let request         = NSFetchRequest(entityName: self.entityName())
        let searchEntity    = NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: BaseDAO.mainMOC)
        request.entity      = searchEntity
        let predicate       = NSPredicate(format: "identification == %@", identification)
        request.predicate   = predicate
        do
        {
            let resultArray = try BaseDAO.mainMOC.executeFetchRequest(request)
            return resultArray as! [WeatherEntity]
        }catch
        {
            return [WeatherEntity]()
        }
    }
    
    static  func createWeatherEntity(dicData:NSMutableDictionary)
    {

        let success = WeatherDAO.createEntityWith { (newEntity:WeatherEntity) -> () in
            
            let realtimedata : NSData  = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("realtime")!)
            let lifedata : NSData      = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("life")!)
            let weatherdata : NSData   = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("weather")!)
            let pmdata : NSData        = NSKeyedArchiver.archivedDataWithRootObject(dicData.valueForKey("pm25")!)
            
            newEntity.realtime         = realtimedata
            newEntity.life             = lifedata
            newEntity.weather          = weatherdata
            newEntity.pm25             = pmdata
          //  WeatherModel.convertFrom(newEntity)
            
        }
        if success == true
        {
            print("保存成功")
            // self.navigationController?.popToRootViewControllerAnimated(true)
        }
        else
        {
            print("保存失败")
        }
    }
    //MARK: - 搜索1条数据
    static  func  SearchCoreDataEntity() -> WeatherEntity
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest(entityName: "WeatherEntity")
        let weatherArray    = try!managedContext.executeFetchRequest(fetchRqeust) as AnyObject as! NSArray
        let weatherEntity   = weatherArray.objectAtIndex(0) as! WeatherEntity
        return weatherEntity
    }
    static  func  SearchOneEntity(index:Int) -> WeatherEntity
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest(entityName: "WeatherEntity")
        let weatherArray    = try!managedContext.executeFetchRequest(fetchRqeust) as AnyObject as! NSArray
        let weatherEntity   = weatherArray.objectAtIndex(index) as! WeatherEntity
        return weatherEntity
    }
    //MARK: - 全部数据
    static func SearchAllDataEntity()->NSArray
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest(entityName: "WeatherEntity")
        let weatherArray    = try!managedContext.executeFetchRequest(fetchRqeust) as AnyObject as! NSArray
        return weatherArray
    }
    //MARK: - 
    static  func  SearchWeatherModel() -> WeatherModel
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest(entityName: "WeatherEntity")
        let fetcheResults   = try!managedContext.executeFetchRequest(fetchRqeust) as AnyObject as! NSArray
        let model           =  WeatherModel.convertFrom(fetcheResults.objectAtIndex(0) as! WeatherEntity)
        return model
    }
   //MARK: - save
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