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
    static func createEntityWith(InitialClosure closure : (_ newEntity : WeatherEntity )->() ) -> Bool
    {
        let entity = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: BaseDAO.mainMOC) as! WeatherEntity
        closure(entity)
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
        BaseDAO.mainMOC.delete(entity)
        return self.save()
    }
    //MARK: - Retrive 按条件搜索数据
    static func retriveEntityWith(ID identification : String) -> [WeatherEntity]
    {
        let request         = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName())
        let searchEntity    = NSEntityDescription.entity(forEntityName: self.entityName(), in: BaseDAO.mainMOC)
        request.entity      = searchEntity
        let predicate       = NSPredicate(format: "identification == %@", identification)
        request.predicate   = predicate
        do
        {
            let resultArray = try BaseDAO.mainMOC.fetch(request)
            return resultArray as! [WeatherEntity]
        }catch
        {
            return [WeatherEntity]()
        }
    }
    
    static  func createWeatherEntity(_ dicData:NSMutableDictionary)
    {

        let success = WeatherDAO.createEntityWith { (newEntity:WeatherEntity) -> () in
            
            let realtimedata : Data  = NSKeyedArchiver.archivedData(withRootObject: dicData.value(forKey: "realtime")!)
            let lifedata : Data      = NSKeyedArchiver.archivedData(withRootObject: dicData.value(forKey: "life")!)
            let weatherdata : Data   = NSKeyedArchiver.archivedData(withRootObject: dicData.value(forKey: "weather")!)
            let pmdata : Data        = NSKeyedArchiver.archivedData(withRootObject: dicData.value(forKey: "pm25")!)
            
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
        let weatherArray    = try!managedContext.fetch(fetchRqeust) as AnyObject as! NSArray
        let weatherEntity   = weatherArray.object(at: 0) as! WeatherEntity
        return weatherEntity
    }
    static  func  SearchOneEntity(_ index:Int) -> WeatherEntity
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest(entityName: "WeatherEntity")
        let weatherArray    = try!managedContext.fetch(fetchRqeust) as AnyObject as! NSArray
        let weatherEntity   = weatherArray.object(at: index) as! WeatherEntity
        return weatherEntity
    }
    //MARK: - 全部数据
    static func SearchAllDataEntity()->NSArray
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        let weatherArray    = try!managedContext.fetch(fetchRqeust) as AnyObject as! NSArray
        return weatherArray
    }
    //MARK: - 0
    static  func  SearchWeatherModel() -> WeatherModel
    {
        let managedContext  = BaseDAO.mainMOC
        let fetchRqeust     = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        let fetcheResults   = try!managedContext.fetch(fetchRqeust) as AnyObject as! NSArray
        let model           =  WeatherModel.convertFrom(fetcheResults.object(at: 0) as! WeatherEntity)
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
