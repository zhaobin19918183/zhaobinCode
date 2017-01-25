//
//  HomeViewController.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/26.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation

class HomeViewController: UIViewController {
 
    weak var bookListEntity : BookListEntity?
    var EndDic:NSDictionary!
    var EndArray:NSArray!
    var avAudioPlayer:AVAudioPlayer!
    var TestViewController:testViewController!
    override func viewDidLoad()
    {
        super.viewDidLoad()
       //alamofireUploadFile()
        let webView = UIWebView(frame:self.view.bounds)
        let url = NSURL(string: "https://www.baidu.com")
        let request = NSURLRequest(url: url as! URL)
        webView.loadRequest(request as URLRequest)
        self.view.addSubview(webView)
         netWorkStatusType()
        TestViewController = testViewController()
        self.addChildViewController(TestViewController)
       

    }
    func initAVAudioPlayer(){
        do{
            try self.avAudioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "Stream", ofType: "mp3")!) as URL)
            self.avAudioPlayer.play()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
   
    func netWorkStatusType()
    {
        let manager = NetWorkManager.networkStateJudgement()
        print(manager.SuccessOrError,manager.type)
    }
    
    func coreDataArray()
    {
        print(BookListDAO.SearchAllDataEntity().count)
        
        for  dic in BookListDAO.SearchAllDataEntity()
        {
            let dicBookList = dic as! BookListEntity
            print(dicBookList.date! as String)
        }

    }

    func  alamofireRequest()
    {
        Alamofire.request("http://op.juhe.cn/onebox/basketball/nba?dtype=&=&key=a77b663959938859a741024f8cbb11ac").responseJSON { (data) in
            let dic = data.result.value  as! [String:AnyObject]
            let arr = dic["result"]?["list"] as! NSArray
            self.EndDic = arr.object(at: 0) as! NSDictionary
           
//            self.EndArray = self.EndDic.value(forKey: "tr") as! NSArray!
        }
       
      
            
    }
    
    func alamofireUploadFile()
    {
        let image : UIImage = UIImage(named:"屏幕快照 2016-09-02 下午12.40.08.png")!
        let imageData       = UIImagePNGRepresentation(image)
        let parameters      = ["name":"Adis4"]
        NetWorkManager.alamofireUploadFile(url: "http://127.0.0.1:8000/blog/home", parameters: parameters, data:imageData!, withName: "image", fileName: "zhaobin.png")
        
    }
    func  bengkui()
    {
            let image : UIImage = UIImage(named:"屏幕快照 2016-09-02 下午12.40.08.png")!
            let imageData       = UIImagePNGRepresentation(image)
            let parameters      = ["name":"zhaobin", "date": "2011-10-11", "address" : "address","number" : "111111111111111111","email"   : "bin.zhao@innocellence.com"]
            NetWorkManager.alamofireUploadFile(url: "http://127.0.0.1:8000/blog/wxSmall", parameters: parameters, data:imageData!, withName: "image", fileName: "zhaobin.png")
    }
    
    
//    let image : UIImage = UIImage(named:"屏幕快照 2016-09-02 下午12.40.08.png")!
//    let imageData       = UIImagePNGRepresentation(image)
//    let parameters      = ["name":"zhaobin", "date": "2011-10-11", "address" : "address","number" : "111111111111111111","email"   : "bin.zhao@innocellence.com"]
//    NetWorkManager.alamofireUploadFile(url: "http://127.0.0.1:8000/polls/wxSmall", parameters: parameters, data:imageData!, withName: "image", fileName: "zhaobin.png")
//}


}
