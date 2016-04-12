//
//  AlamofireView.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/4/7.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import Alamofire

class AlamofireView: NSObject
{
    //下载进度封装
    //request, response, data, error
    class func alamofireDelegate(url:String,complete:(bytesRead:Int64, totalBytesRead:Int64, totalBytesExpectedToRead:Int64)->Void)
    {
       
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
         Alamofire.download(.GET, url, destination: destination).progress(complete)
        
    }
    

    class func alamofiredown()
    {
        //    Alamofire.download(.GET, url, parameters: [String : AnyObject]?, encoding: ParameterEncoding.JSON, headers: [String : String]?) { (NSURL, NSHTTPURLResponse) -> NSURL in
        //
        //    }
    
    }


}
