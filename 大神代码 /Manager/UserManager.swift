//
//  UserManager.swift
//  Portal
//
//  Created by Kilin on 16/3/15.
//  Copyright © 2016年 Innocellence. All rights reserved.
//

import UIKit

struct UserManager
{
    static let sharedManager = UserManager()
    private init() {}
    
    var settings : NSDictionary
    {
        let settingsFilePath = NSBundle.mainBundle().pathForResource("Settings", ofType: "plist")
        assert(settingsFilePath != nil, "Didn't found 'Settings.plist' file!")
        let settings : NSDictionary = NSDictionary(contentsOfFile: settingsFilePath!)!
        
        return settings
    }
    
    var username : String
    {
        if let environment = settings["Environment"] as? String where environment == "LOCAL"
        {
            return String(settings["LocalUser"]!)
        }
        
        guard LYKeyChainManager.getLillyAccountUserIdFromKeychain() != nil else
        {
            return ""
        }
        
        return LYKeyChainManager.getLillyAccountUserIdFromKeychain()
    }
    
    var password : String
    {
        if let environment = settings["Environment"] as? String where environment == "LOCAL"
        {
            return ""
        }
        
        if LYKeyChainManager.getLillyAccountPasswordFromKeychain() == nil
        {
            return ""
        }else
        {
            return LYKeyChainManager.getLillyAccountPasswordFromKeychain()
        }
    }
    
    var identify : SecIdentityRef?
    {
        guard LYKeyChainManager.getLillyUserIdentityCopyFromKeychain() != nil else
        {
            return nil
        }
        
        return LYKeyChainManager.getLillyUserIdentityCopyFromKeychain().takeUnretainedValue()
    }
}











