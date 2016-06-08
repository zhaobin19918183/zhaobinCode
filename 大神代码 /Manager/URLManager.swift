//
//  URLManager.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

struct URLManager
{
    static let sharedManager = URLManager()
    private init(){}
    
    var settings : NSDictionary
    {
        let settingsFilePath = NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")
        assert(settingsFilePath != nil, "Didn't found 'Settings.plist' file!")
        let settings : NSDictionary = NSDictionary(contentsOfFile: settingsFilePath!)!
        
        return settings
    }
    
    var rootURL : String
    {
        let environment = settings["Environment"] as? String
        let environmentDetail = settings["EnvironmentDetail"] as? NSDictionary
        
        let rootURL = environmentDetail![environment!]
        return String(rootURL!)
    }
    
    var postDeviceTokenURL : String!
    {
        let environment = settings["Environment"] as? String
        let postDeviceToken = settings["PostDeviceToken"] as? NSDictionary
        
        let url = postDeviceToken![environment!]!
        return String(url)
    }
}


