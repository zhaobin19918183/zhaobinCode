//
//  FolderManager.swift
//  Portal
//
//  Created by Kilin on 16/3/16.
//  Copyright © 2016年 Innocellence. All rights reserved.
//

import UIKit

struct FolderManager {
    static let sharedManager = FolderManager()
    
    private init() {}
    
    static func createFolderWith(path : String)
    {
        let attrbuteDic = NSDictionary(object: NSFileProtectionComplete, forKey: NSFileProtectionKey)
        let fileManager = NSFileManager.defaultManager()
        
        do{
            try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: attrbuteDic as? [String : AnyObject])
        }catch{}
    }

    static func clearFolderWith(path : String)
    {
        let fileManager = NSFileManager.defaultManager()
        
        do{
            let fileNameArray = try fileManager.contentsOfDirectoryAtPath(path)
            for ( _ , fileName ) in fileNameArray.enumerate()
            {
                do{
                    try fileManager.removeItemAtPath(fileName)
                }catch {}
            }
        }catch {}
    }
    
    static func checkFileExistAt(path : String) -> Bool
    {
        let fileManager = NSFileManager.defaultManager()
        let isExist = fileManager.fileExistsAtPath(path)
        
        return isExist
    }
    
    static func deleteFileAt(path : String)
    {
        let fileManager = NSFileManager.defaultManager()
        
        do{
            try fileManager.removeItemAtPath(path)
        }catch {}
    }
}




