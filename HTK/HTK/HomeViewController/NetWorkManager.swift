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
    

    //NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?
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
                
              
                if jsonDic.valueForKey("result") == nil
                {
                   NSNotificationCenter.defaultCenter().postNotificationName("alamofireError", object: nil)
                }
                else
                {   NSNotificationCenter.defaultCenter().postNotificationName("alamofireSuccess", object: nil)
                    let array = NSArray(objects:jsonDic.valueForKey("result")!)
                    let filePath:String = NSHomeDirectory() + "/Documents/busCar.plist"
                     array.writeToFile(filePath, atomically: true)
                }

              }

        }
    }
}
