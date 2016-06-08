//
//  SchemaManager.swift
//  Portal
//
//  Created by Kilin on 16/3/28.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

let NOTIFICATION_LAUNCHBYSCHEMA = "COM.SMARTSALESTOOL.LaunchBySchema"

struct SchemaManager
{
    static var sharedManager = SchemaManager()
    private init (){
        self.isLaunchBySchema = false
        self.appName = ""
        self.schema = ""
    }
    
    var schema : String{
        didSet{
            self.isLaunchBySchema = true
            
            let components = schema.componentsSeparatedByString("/")
            if components.count >= 3
            {
                self.appName = components[2] as String
                self.appName = self.appName.stringByRemovingPercentEncoding!
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_LAUNCHBYSCHEMA, object: nil)
        }
    }
    
    var isLaunchBySchema : Bool
    var appName : String
}
