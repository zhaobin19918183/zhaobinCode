//
//  HelperManager.swift
//  Portal
//
//  Created by Kilin on 16/3/15.
//  Copyright © 2016年 Innocellence. All rights reserved.
//

import UIKit

struct HelperManager {
    static let sharedManager = HelperManager()
    private init() {}
    
    static func convertAnyObjectToData< T > (anyObject : T) -> NSData
    {
        let resultData : NSData?
        do{
            resultData = try NSJSONSerialization.dataWithJSONObject(anyObject as! AnyObject, options: .PrettyPrinted)
        }catch
        {
            resultData = nil
        }
        
        return resultData!
    }
    
    static func convertDataToAnyObject(data : NSData) -> AnyObject
    {
        let resultAnyObject : AnyObject?
        do{
            resultAnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        }catch
        {
            resultAnyObject = nil
        }
        
        return resultAnyObject!
    }
    
    static func convertDataToString <T> (anyObject : T) -> String
    {
        let resultData : NSData!
        do{
            resultData = try NSJSONSerialization.dataWithJSONObject(anyObject as! AnyObject, options: .PrettyPrinted)
        }catch
        {
            resultData = nil
        }
        
        return String(data: resultData, encoding: NSUTF8StringEncoding)!
    }
    
    static func convertStringToAnyObject(string : String?) -> AnyObject?
    {
        guard let jsonData = string?.dataUsingEncoding(NSUTF8StringEncoding) else
        {
            return nil
        }
        
        let resultAnyObject : AnyObject?
        do{
            resultAnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
        }catch
        {
            resultAnyObject = nil
        }
        
        return resultAnyObject
    }
}









