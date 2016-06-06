//
//  NetWorkManager.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/3.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

import Alamofire



class NetWorkManager: NSObject
{
    var progressHUD : MBProgressHUD!
   

    //MARK:alamofireRequestData
    static func  alamofireRequestData(city:String ,bus:String,url:String)
    {
        let parameters = [
        "dtype":"json",
        "city":city,
        "bus": bus,
        "key": "f572b98772d02d5b4ec1164e8b6fb0f0",
        ]
        
        let status = Reach().connectionStatus()
        let string1 = url
        if  status.description == "Offline"
        {
            //TODO:bus 无网络连接
        }
        else
        {
        
            Alamofire.request(.GET, string1, parameters: parameters ).response { (request, response, data, error) in
                let jsonDic = try! NSJSONSerialization.JSONObjectWithData(data!,
                    options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
                
              
                if (jsonDic.valueForKey("reason") as! String) == "city or bus may not matching"
                {
                   NSNotificationCenter.defaultCenter().postNotificationName("alamofireError", object: nil)
                }
                else
                {   NSNotificationCenter.defaultCenter().postNotificationName("alamofireSuccess", object: nil)
                    let array = NSArray(objects:jsonDic.valueForKey("result")!)
                    let filePath = NSBundle.mainBundle().pathForResource("dataList.plist", ofType:nil )
                     array.writeToFile(filePath!, atomically: true)
                }

              }

        }
    }
    //MARK:alamofireWeatherRequestData
    static func  alamofireWeatherRequestData(city:String ,url:String,key:String,dtype:String)
    {
        let parameters = [
            "dtype":dtype,
            "cityname":city,
            "key": key,
            ]
        weak var weatherEntity : WeatherEntity?
        weak var dataDic  = NSMutableDictionary()
          
        Alamofire.request(.GET, url,parameters: parameters).response{(request, response, data, error) in
            
            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
            dataDic = jsonArr?.valueForKey("result")?.valueForKey("data") as?NSMutableDictionary
            if(NSUserDefaults.standardUserDefaults().valueForKey("first") != nil)
            {
                weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
                WeatherDAO.deleteEntityWith(Entity: weatherEntity!)
                WeatherDAO.createNewPassWordData(dataDic!)
                
            }
            else
            {
                
                WeatherDAO.createNewPassWordData(dataDic!)
                NSUserDefaults.standardUserDefaults().setObject("first", forKey: "first")
                
            }
            NSNotificationCenter.defaultCenter().postNotificationName("WeatherData", object: nil)
            //self.dataFunc()
            
        }
        
    }

}



