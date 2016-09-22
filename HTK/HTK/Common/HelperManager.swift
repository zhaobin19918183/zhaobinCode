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
    fileprivate init() {}
    
    static func convertAnyObjectToData< T > (_ anyObject : T) -> Data
    {
        let resultData : Data?
        do{
            resultData = try JSONSerialization.data(withJSONObject: anyObject as AnyObject, options: .prettyPrinted)
        }catch
        {
            resultData = nil
        }
        
        return resultData!
    }
    
    static func convertDataToAnyObject(_ data : Data) -> AnyObject
    {
        let resultAnyObject : AnyObject?
        do{
            resultAnyObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        }catch
        {
            resultAnyObject = nil
        }
        
        return resultAnyObject!
    }
    
    static func convertDataToString <T> (_ anyObject : T) -> String
    {
        let resultData : Data!
        do{
            resultData = try JSONSerialization.data(withJSONObject: anyObject as AnyObject, options: .prettyPrinted)
        }catch
        {
            resultData = nil
        }
        
        return String(data: resultData, encoding: String.Encoding.utf8)!
    }
    
    static func convertStringToAnyObject(_ string : String?) -> AnyObject?
    {
        guard let jsonData = string?.data(using: String.Encoding.utf8) else
        {
            return nil
        }
        
        let resultAnyObject : AnyObject?
        do{
            resultAnyObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        }catch
        {
            resultAnyObject = nil
        }
        
        return resultAnyObject
    }
    static func convertServerTimeToLocalTime(_ dateString : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone   = TimeZone(secondsFromGMT: 0)
        let convertedDate = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: convertedDate!)
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: convertedDate!)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: convertedDate!)
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
        return dateFormatter.string(from: convertedDate!)
    }
    
    static func convertServerTimeToDateString(_ dateString : String) -> (day : String , month : String)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone   = TimeZone(secondsFromGMT: 0)
        let convertedDate = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "MM"
        let monthString = dateFormatter.string(from: convertedDate!)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: convertedDate!)
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

