//
//  ProgressView.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/4/1.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import Alamofire

class ProgressView: UIView {
    
    var progressView: UIProgressView!
    var remainTime = 100
    func  progressAction()
    {
        // 初始化 progressView
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
        progressView.frame = CGRectMake(self.frame.width/2 - 50, 200, 300, 100)
        // 设置初始值
        progressView.progress = 1.0
        // 设置进度条颜色
        progressView.progressTintColor = UIColor.blueColor()
        // 设置进度轨迹颜色
        progressView.trackTintColor = UIColor.greenColor()
        // 扩展：可以通过 progressImage、trackImage 属性自定义出个性进度条
        self.addSubview(progressView)
        reloadData()
    }
    func reloadData()
    {
        
        let destination = Alamofire.Request.suggestedDownloadDestination(
            directory: .DocumentDirectory, domain: .UserDomainMask)
        
        let url = "http://img2.imgtn.bdimg.com/it/u=1457437487,655486635&fm=11&gp=0.jpg"
        Alamofire.download(.GET, url, destination: destination)
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                
                let percent = totalBytesRead*100/totalBytesExpectedToRead
                self.remainTime   = self.remainTime - Int(percent)
                self.progressView.setProgress(Float(self.remainTime)/100, animated:true)
                print("已下载：\(totalBytesRead)  当前进度：\(percent)%")
            }
            .response { (request, response, data, error) in
                
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory,
                    inDomains: .UserDomainMask)[0]
                let pathComponent = response!.suggestedFilename
                print(directoryURL.URLByAppendingPathComponent(pathComponent!))
                print(response)
        }
        
        
        
    }
    

    
}
