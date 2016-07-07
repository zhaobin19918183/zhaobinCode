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
    static func convertServerTimeToLocalTime(dateString : String) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone   = NSTimeZone(forSecondsFromGMT: 0)
        let convertedDate = dateFormatter.dateFromString(dateString)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.stringFromDate(convertedDate!)
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.stringFromDate(convertedDate!)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.stringFromDate(convertedDate!)
        switch monthString {
        case "01":
            let  month  = "January"
            return  ("\(day) \(month) \(year)")
        case "02":
            let  month  = "February"
            return  ("\(day) \(month) \(year)")
        case "03":
            let  month  = "March"
            return  ("\(day) \(month) \(year)")
        case "04":
            let  month  = "April"
            return  ("\(day) \(month) \(year)")
        case "05":
            let  month  = "May"
            return  ("\(day) \(month) \(year)")
        case "06":
            let  month  = "June"
            return  ("\(day) \(month) \(year)")
        case "07":
            let  month  = "July"
            return  ("\(day) \(month) \(year)")
        case "08":
            let  month  = "August"
            return  ("\(day) \(month) \(year)")
        case "09":
            let  month  = "September"
            return  ("\(day) \(month) \(year)")
        case "10":
            let  month  = "October"
            return  ("\(day) \(month) \(year)")
        case "11":
            let  month  = "November"
            return  ("\(day) \(month) \(year)")
        case "12":
            let  month  = "December"
            return  ("\(day) \(month) \(year)")
        default:
            break
        }
        return dateFormatter.stringFromDate(convertedDate!)
    }
    
    static func convertServerTimeToDateString(dateString : String) -> (day : String , month : String)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone   = NSTimeZone(forSecondsFromGMT: 0)
        let convertedDate = dateFormatter.dateFromString(dateString)
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.stringFromDate(convertedDate!)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.stringFromDate(convertedDate!)
        switch monthString {
        case "01":
            let  month   = "January"
            return (day , month)
        case "02":
            let  month   = "February"
            return (day , month)
            
        case "03":
            let  month   = "March"
            return (day , month)
        case "04":
            let  month   = "April"
            return (day , month)
        case "05":
            let  month   = "May"
            return (day , month)
        case "06":
            let  month   = "June"
            return (day , month)
        case "07":
            let  month   = "July"
            return (day , month)
        case "08":
            let  month   = "August"
            return (day , month)
        case "09":
            let  month   = "September"
            return (day , month)
        case "10":
            let  month   = "October"
            return (day , month)
        case "11":
            let  month   = "November"
            return (day , month)
        case "12":
            let  month   = "December"
            return (day , month)
        default:
            break
        }
        return (day,monthString)
        
    }

   
    
}









