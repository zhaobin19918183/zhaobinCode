//
//  BookListDAO.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import CoreData


class BookListDAO: BaseDAO
{
    //MARK: - Create
    static func createEntityWith(InitialClosure closure : (_ newEntity : BookListEntity )->() ) -> Bool
    {
        let entity = NSEntityDescription.insertNewObject(forEntityName: self.entityName(), into: BaseDAO.mainMOC) as! BookListEntity
        closure(entity)
        return self.save()
    }
    //MARK: 保存数据
    static func creatBookListEntity(_ dicData : NSDictionary)
    {
        let success = BookListDAO.createEntityWith(InitialClosure: { (booklistentity:BookListEntity) in
            let name = dicData.value(forKey: "name") as! String
            let date = dicData.value(forKey: "date") as! String
            let number = dicData.value(forKey: "number") as! String
            booklistentity.name = name
            booklistentity.date = date
            booklistentity.number = number
             
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
    static func deleteEntityWith(Entity entity : BookListEntity) -> Bool
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
