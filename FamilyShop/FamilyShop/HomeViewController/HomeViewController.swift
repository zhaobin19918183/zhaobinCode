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


class HomeViewController: UIViewController {

    @IBOutlet weak var _backgroundScollView: UIScrollView!
    
    @IBOutlet weak var _firstView: UIView!
    @IBOutlet weak var _secondView: UIView!
    @IBOutlet weak var _threeView: UIView!
    @IBOutlet weak var _fourView: UIView!
    @IBOutlet weak var _fiveView: UIView!
    @IBOutlet weak var _sixView: UIView!
    @IBOutlet weak var testButton: UIButton!
    weak var bookListEntity : BookListEntity?
    var manager: NetworkReachabilityManager?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        networkStateJudgement()


    }
    
    @IBAction func testButtonAction(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewController(withIdentifier: "ShopCarViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    //MARK: - 网络识别
    func networkStateJudgement()
    {
        self.manager = NetworkReachabilityManager(host: "www.apple.com")
        self.manager?.startListening()
        if (self.manager?.isReachable)!
        {
            self.manager?.listener = { status in
                if status == NetworkReachabilityManager.NetworkReachabilityStatus.reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi) {
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
           print("网络连接失败: \(self.manager?.isReachable)")
        }
    }
    
    
    func coreDataArray()
    {
        print(BookListDAO.SearchAllDataEntity().count)
        
        for index in 0...BookListDAO.SearchAllDataEntity().count - 1
        {
            self.bookListEntity = BookListDAO.SearchAllDataEntity()[index] as? BookListEntity
            print(self.bookListEntity?.name)
        }
    
    }

    func  alamofireRequest()
    {
        Alamofire.request("http://127.0.0.1:8000/polls/book/?format=json").responseJSON { (data) in
            
           
            let dic = data.result.value  as! [String:AnyObject]
            let count = (dic["results"]?.count)! as Int
            for index in 0...count - 1
            {
               print("indx:\(index) dic ===\(dic["results"]?.objectAt(index).allKeys)")
              // BookListDAO.creatBookListEntity((dic["results"]?.objectAt(index))! as! NSDictionary)
            }
           
        
        }
       
      
            
    }
    
    func alamofireUploadFile()
    {
        let image : UIImage = UIImage(named:"屏幕快照 2016-09-02 下午12.40.08.png")!
        let imageData       = UIImagePNGRepresentation(image)
        let parameters      = ["name":"Adis4"]
        NetWorkManager.alamofireUploadFile(url: "http://127.0.0.1:8000/polls/home", parameters: parameters, data:imageData!, withName: "image", fileName: "zhaobin.png")
    }

}
