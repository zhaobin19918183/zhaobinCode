//
//  NetWorkManager.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/26.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class NetWorkManager: NSObject
{
    
    static func networkStateJudgement()
    {
        var manager: NetworkReachabilityManager?
        
        manager = NetworkReachabilityManager(host: "www.apple.com")
        manager?.startListening()
        if (manager?.isReachable)!
        {
            manager?.listener = { status in
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi)
                {
                    
                    print(" ethernetOrWiFi : \(status)")
               
                    
                }
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.unknown
                {
                    print("无法识别: \(status)")
                }
                
            }
            
        }
        else
        {
            print("网络连接失败: \(manager?.isReachable)")
           
        }
        

    }
    

    
    static  func alamofireUploadFile(url:String,parameters:[String:String],data: Data, withName name: String, fileName: String)
    {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data, withName:name, fileName: fileName, mimeType: "image/png")
            for (key, value) in parameters
            {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
            
        }, to: url) { (encodingResult) in
                switch encodingResult
                {
                case .success(let upload, _, _):
                upload.responseJSON
                {
                response in
                debugPrint(response)
                let string : String = String(data: response.data!, encoding: String.Encoding.utf8)!
                if string == "success"
                {
                print("成功")
                }
                else
                {
                print("失败")
                }
                
                
                }
                case .failure(let encodingError):
                print(encodingError)
                print("error")
                }
            
        }
    
    }
    

}
