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
       let imageURL:NSURL = NSURL(string: "http://www.szplanner.com/images/inside/product_thumb.jpg")!
        
        SDWebImageManager.sharedManager().downloadImageWithURL(imageURL, options: SDWebImageOptions(), progress: { (min:Int, max:Int) -> Void in
            
            print("加载中 ")
            
        }) { (image:UIImage!, error:NSError!, cacheType:SDImageCacheType, finished:Bool, url:NSURL!) -> Void in
            
            if (image != nil)
            {
                print("图片缓存完成")
            }
        }
    
    }


}
