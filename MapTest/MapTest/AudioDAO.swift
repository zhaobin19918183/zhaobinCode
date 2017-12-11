//
//  AudioDAO.swift
//  MapTest
//
//  Created by newland on 2017/12/11.
//  Copyright © 2017年 newland. All rights reserved.
//

import UIKit
import CoreData

class AudioDAO: BaseDAO {
    
    //MARK: - Create
    static func createEntityWith(InitialClosure closure : (_ newEntity : AudioEntity )->() ) -> Bool
    {
        let entity = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: BaseDAO.mainMOC) as! AudioEntity
        closure(entity)
        return self.save()
    }
    //MARK: 保存数据
    static func creatBookListEntity(_ dicData : NSDictionary)
    {
        let success = AudioDAO.createEntityWith(InitialClosure: { (audioentity:AudioEntity) in

            let filelong = dicData.value(forKey: "filelong") as! String
            let fileName = dicData.value(forKey: "fileName") as! String
            let fileTime = dicData.value(forKey: "fileTime") as! Date
            let fileDistance = dicData.value(forKey: "fileDistance") as! String
            let fileTimeLong = dicData.value(forKey: "fileTimeLong") as! String
            let fileCoordinate = dicData.value(forKey: "fileCoordinate") as! Data
            let fuileNumber = dicData.value(forKey: "fuileNumber") as! Data
            let filetime1 = dicData.value(forKey: "filetime1") as! Data
            let filetime2 = dicData.value(forKey: "filetime1") as! Data
            let filetime3 = dicData.value(forKey: "fileTime3") as! Data
            audioentity.filelong = filelong
            audioentity.fileName = fileName
            audioentity.fileTime = fileTime
            audioentity.fileDistance = fileDistance
            audioentity.fileTimeLong = fileTimeLong
            audioentity.fileCoordinate = fileCoordinate
            audioentity.fuileNumber = fuileNumber
            audioentity.filetime1 = filetime1
            audioentity.filetime2 = filetime2
            audioentity.filetime3 = filetime3
            
            

            
        })
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
    
    //MARK: - 全部数据
    static func SearchAllDataEntity()->NSArray
    {
        var dataSource = NSArray()
        let managedContext  = BaseDAO.mainMOC
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: "BookListEntity", in: managedContext)
        request.entity = entity
        dataSource = try!managedContext.fetch(request)  as NSArray
        
        return dataSource
    }
    
    //MARK: - Delete
    static func deleteEntityWith(Entity entity : AudioEntity) -> Bool
    {
        BaseDAO.mainMOC.delete(entity)
        return self.save()
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
        return "BookListEntity"
    }

}
