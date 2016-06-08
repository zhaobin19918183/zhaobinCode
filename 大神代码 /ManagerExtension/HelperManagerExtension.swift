//
//  HelperManagerExtension.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

extension HelperManager
{
    static func getUnzipedAppPathWith(entity : Entity_App) -> String
    {
        let appNameWithoutExtension = String(entity.applicationCode!)
        return PATH_FOLDER_APP + appNameWithoutExtension
    }
    
    static func getAppNameWithoutExtensionWith(entity : Entity_App) -> String
    {
        let appNameWithExtension    = self.getAppNameWithExtensionWith(entity)
        let seperators              = appNameWithExtension.componentsSeparatedByString(".")
        let appNameWithoutExtension = seperators.first!
        
        return appNameWithoutExtension
    }
    
    static func getAppNameWithExtensionWith(entity : Entity_App) -> String
    {
        let package : String        = entity.applicationPackage!
        let sepratedPath : [String] = package.componentsSeparatedByString("/")
        let name : String           = sepratedPath.last! as String
        
        return name
    }
}

