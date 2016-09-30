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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

       

    }
    
    @IBAction func testButtonAction(_ sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewController(withIdentifier: "ShopCarViewController")
        self.navigationController?.pushViewController(target, animated:true)
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
            print(dicBookList.date)
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
               BookListDAO.creatBookListEntity((dic["results"]?.objectAt(index))! as! NSDictionary)
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
