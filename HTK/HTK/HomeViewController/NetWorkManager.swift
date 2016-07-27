//
//  NetWorkManager.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/3.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

import Alamofire

typealias completionWithResponse     = (request : NSURLRequest? , response : NSHTTPURLResponse? , data : NSData? , error : NSError?) -> Void

class NetWorkManager: NSObject
{
    var progressHUD : MBProgressHUD!
    //MARK:测试
    static func  callbackData(city:String ,bus:String,url:String,complete:completionWithResponse)
    {
        let parameters = [
            "dtype":"json",
            "city":city,
            "bus": bus,
            "key": "f572b98772d02d5b4ec1164e8b6fb0f0",
            ]

        let string1 = url

        Alamofire.request(.GET, string1, parameters: parameters ).response { (request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?, error:NSError?)->Void in complete(request: request , response: response , data: data , error: error)
            
        }

        
    }
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
                {
                    NSNotificationCenter.defaultCenter().postNotificationName("alamofireSuccess", object: nil)
                    let array = NSArray(objects:jsonDic.valueForKey("result")!)
                    
//                    let filePath = NSBundle.mainBundle().pathForResource("dataList.plist", ofType:nil )
//                    array.writeToFile(filePath!, atomically: true)
                    
                   let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    let documentPath = documentPaths[0]

                    print(documentPath)
                    
                    let filePath1:String = documentPath + "/dataList.plist"
                    array.writeToFile(filePath1, atomically: true)
                    
                    
                   let succ = array.writeToFile(filePath1, atomically:true)
                    print(succ)
                    
                }

              }

        }
    }
    //MARK:alamofireWeatherRequestData
    
    private  static var alamofireManager:Manager =
    {
        var alamofireManager : Manager?
        // 设置请求的超时时间
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 0.002    // 秒
        alamofireManager = Manager(configuration: config)
        return alamofireManager!
    }()
    
    static func  alamofireWeatherRequestData(city:String ,url:String,key:String,dtype:String)
    {
        let parameters = [
            "dtype":dtype,
            "cityname":city,
            "key": key,
            ]
        weak var weatherEntity : WeatherEntity?
        weak var dataDic  = NSMutableDictionary()
        alamofireManager.request(.GET, url,parameters: parameters).response{(request, response, data, error) in
            if error?.localizedDescription == "The request timed out."
            {
              //TODO:超时
                NSNotificationCenter.defaultCenter().postNotificationName("TimeOut", object: error)
                print("The request timed out")
                
            }
            else
            {
                let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                    options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
                dataDic = jsonArr?.valueForKey("result")?.valueForKey("data") as?NSMutableDictionary
                
                if(NSUserDefaults.standardUserDefaults().valueForKey("first") != nil)
                {
                    weatherEntity = WeatherDAO.SearchCoreDataEntity()
                    WeatherDAO.deleteEntityWith(Entity: weatherEntity!)
                    WeatherDAO.createWeatherEntity(dataDic!)
                }
                else
                {
                    WeatherDAO.createWeatherEntity(dataDic!)
                    NSUserDefaults.standardUserDefaults().setObject("first", forKey: "first")
                }
                NSNotificationCenter.defaultCenter().postNotificationName("WeatherData", object: nil)
            }
        }
    }

}



