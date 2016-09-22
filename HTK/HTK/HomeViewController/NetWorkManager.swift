//
//  NetWorkManager.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/3.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

import Alamofire

typealias completionWithResponse     = (_ request : URLRequest? , _ response : HTTPURLResponse? , _ data : Data? , _ error : NSError?) -> Void

class NetWorkManager: NSObject
{
    var progressHUD : MBProgressHUD!
    //MARK:测试
    static func  callbackData(_ city:String ,bus:String,url:String,complete:@escaping completionWithResponse)
    {
        let parameters = [
            "dtype":"json",
            "city":city,
            "bus": bus,
            "key": "f572b98772d02d5b4ec1164e8b6fb0f0",
            ]

        let string1 = url

        Alamofire.request(.GET, string1, parameters: parameters ).response { (request:URLRequest?, response:HTTPURLResponse?, data:Data?, error:NSError?)->Void in complete(request: request , response: response , data: data , error: error)
            
        }

        
    }
    //MARK:alamofireRequestData
    static func  alamofireRequestData(_ city:String ,bus:String,url:String)
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
                let jsonDic = try! JSONSerialization.jsonObject(with: data!,
                    options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                
              
                if (jsonDic.value(forKey: "reason") as! String) == "city or bus may not matching"
                {
                   NotificationCenter.default.post(name: Notification.Name(rawValue: "alamofireError"), object: nil)
                }
                else
                {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "alamofireSuccess"), object: nil)
                    let array = NSArray(objects:jsonDic.value(forKey: "result")!)
                    
//                    let filePath = NSBundle.mainBundle().pathForResource("dataList.plist", ofType:nil )
//                    array.writeToFile(filePath!, atomically: true)
                    
                   let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                    let documentPath = documentPaths[0]

                    print(documentPath)
                    
                    let filePath1:String = documentPath + "/dataList.plist"
                    array.write(toFile: filePath1, atomically: true)
                    
                    
                   let succ = array.write(toFile: filePath1, atomically:true)
                    print(succ)
                    
                }

              }

        }
    }
    //MARK:alamofireWeatherRequestData
    
    fileprivate  static var alamofireManager:Manager =
    {
        var alamofireManager : Manager?
        // 设置请求的超时时间
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10    // 秒
        alamofireManager = Manager(configuration: config)
        return alamofireManager!
    }()
    
    static func  alamofireWeatherRequestData(_ city:String ,url:String,key:String,dtype:String)
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
                NotificationCenter.default.post(name: Notification.Name(rawValue: "TimeOut"), object: error)
                print("The request timed out")
                
            }
            else
            {
                let jsonArr = try! JSONSerialization.jsonObject(with: data!,
                    options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary
                dataDic = jsonArr?.value(forKey: "result")?.value(forKey: "data") as?NSMutableDictionary
                
                if(UserDefaults.standard.value(forKey: "first") != nil)
                {
                    weatherEntity = WeatherDAO.SearchCoreDataEntity()
                    WeatherDAO.deleteEntityWith(Entity: weatherEntity!)
                    WeatherDAO.createWeatherEntity(dataDic!)
                }
                else
                {
                    WeatherDAO.createWeatherEntity(dataDic!)
                    UserDefaults.standard.set("first", forKey: "first")
                }
                NotificationCenter.default.post(name: Notification.Name(rawValue: "WeatherData"), object: nil)
            }
        }
    }

}



