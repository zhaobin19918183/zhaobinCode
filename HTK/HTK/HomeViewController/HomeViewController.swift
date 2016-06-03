//
//  HomeViewController.swift
//  HTK
//
//  Created by 赵斌 on 16/5/16.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    weak var weatherEntity : WeatherEntity?
    weak var dataDic  = NSMutableDictionary()
    @IBOutlet weak var _weather: WeatherView!
    @IBOutlet weak var _traffic: TrafficView!
    @IBOutlet weak var collectionView: UICollectionView!
   
    var progressHUD : MBProgressHUD!
    var imageArray = ["basketball","football","news","wifi.jpg","jiazhao.jpg"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        weatherCoredata()
        weatherMoreButtonAction()
        trafficViewSearchButtonAction()
        _traffic.pickerView = self.parentViewController!
        collectionView.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        
      
        
    }
    //TODO:CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellID", forIndexPath: indexPath) as? HomeCollectionViewCell
        if cell == nil
        {
            let nibArray : NSArray = NSBundle.mainBundle().loadNibNamed("HomeCollectionViewCell", owner:self, options:nil)
            cell = nibArray.firstObject as? HomeCollectionViewCell
        }
        cell?.backgroundimagView.image = UIImage(named: imageArray[indexPath.row])
        return cell!
        
    }
    
    //MARK:weatherMoreButtonAction
    func weatherMoreButtonAction()
    {
        _weather.moreButton.addTarget(self, action:#selector(HomeViewController.moreWeather), forControlEvents: UIControlEvents.TouchDown)
        
    }
    //MARK:trafficViewSearchButtonAction
    func trafficViewSearchButtonAction()
    {
        _traffic.searchButton.addTarget(self, action:#selector(HomeViewController.searchTraffic), forControlEvents: UIControlEvents.TouchDown)
        
    }
    //MARK:searchTraffic
    func searchTraffic()
    {
        
        self.prpgressHud()
//        DataLogicJudgment()
        alamofireRequestData()
        
     
    }
    //MARK: 数据逻辑判断 回家在做 啦啦啦啦
    func  DataLogicJudgment()
    {
    //1.查询方式选择
    //2.线路添加,换乘方案,站台.
       //|| _traffic.lineTextField.text == nil
        if _traffic.project == nil
        {
         self.progressHUD.hide(true, afterDelay:0)
          //数据添加错误
        }
        else
            
        {
            print("判断 ===== \(_traffic.project)")
            if _traffic.project == "1"
            {
             //线路
                
            }
            if _traffic.project == "2"
            {
              //车辆
            }
            if _traffic.project == "3"
            {
               //换乘
            }
        
        }
        
    
    }
    //MARK:申请数据
    func  alamofireRequestData()
    {
    
        let string1 = "http://op.juhe.cn/189/bus/busline"
        Alamofire.request(.GET, string1, parameters: ["dtype":"","city":"大连","bus":"3","key":"f572b98772d02d5b4ec1164e8b6fb0f0"]).response { (request, response, data, error) in
            let jsonDic = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
            
            self.progressHUD.hide(true, afterDelay:0.25)

            let array = NSArray(objects:jsonDic.valueForKey("result")!)
            let filePath:String = NSHomeDirectory() + "/Documents/busCar.plist"
            array.writeToFile(filePath, atomically: true)
            
            
            if jsonDic.valueForKey("result") == nil
            {
                
            }else
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let target = storyboard.instantiateViewControllerWithIdentifier("busTableViewViewController")
                as! BusTableViewController
                self.navigationController?.pushViewController(target, animated:true)
                
            }
            
        }
    }

    //MARK:MBProgressHUD
    func prpgressHud()
    {
        progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "正在申请数据......"
        //背景渐变效果
        progressHUD.dimBackground = true
    

    }
    func moreWeather()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("moreWeatherViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    
    
    func netWorkAlert()
    {
        let alert  = UIAlertController(title:"提示", message:"无网络连接", preferredStyle:UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            exit(0)
            
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated:true, completion:nil)
    }
    //MARK:Alamofire
    func weatherAlamofire()
    {
        
        let string1 = "http://op.juhe.cn/onebox/weather/query?cityname="
        let string2 = "&dtype=&key=e527188bbf687ccccac5350acf9a151f"
        let string  = "大连"
        let urlString = string.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let string3 = string1+urlString!+string2
        Alamofire.request(.GET, string3).response{(request, response, data, error) in
            
            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
            self.dataDic = jsonArr?.valueForKey("result")?.valueForKey("data") as?NSMutableDictionary
            if(NSUserDefaults.standardUserDefaults().valueForKey("first") != nil)
            {
                self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
                WeatherDAO.deleteEntityWith(Entity: self.weatherEntity!)
                WeatherDAO.createNewPassWordData(self.dataDic!)
                
            }
            else
            {
                
                WeatherDAO.createNewPassWordData(self.dataDic!)
                NSUserDefaults.standardUserDefaults().setObject("first", forKey: "first")
                
            }
            
            self.dataFunc()
            
        }
        
    }
    func weatherCoredata()
    {
        let status = Reach().connectionStatus()
        if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
            
            switch status {
            case .Unknown, .Offline:
                netWorkAlert()
            case .Online(.WWAN):
                weatherAlamofire()
            case .Online(.WiFi):
                weatherAlamofire()
            }
            
        }
        else
        {
            switch status {
            case .Unknown, .Offline:
                dataFunc()
            case .Online(.WWAN):
                dataFunc()
            case .Online(.WiFi):
                weatherAlamofire()
            }
        }
        
    }
    
    
    func  dataFunc()
    {
        
        self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
        let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("realtime"))! as! NSData)! as! NSDictionary
        
        let windDic = dictionary.valueForKey("wind")
        let  weatherDic = dictionary.valueForKey("weather")
        let  info = weatherDic!.valueForKey("info") as! String
        let temp = "°"
        _weather.tempratureLabel.text = (weatherDic?.valueForKey("temperature") as? String)!+temp
        let pow = "风力:"
        _weather.powerLabel.text = pow+((windDic?.valueForKey("power"))! as! String)
        let dire = "风向:"
        _weather.directLabel.text = dire+((windDic?.valueForKey("direct"))! as! String)
        let img = UIImage(named:(weatherDic?.valueForKey("img"))! as! String)
        _weather.weatherImageView.image = img
        let moon = " 农历 :  "
        _weather.dateLabel.text = (dictionary.valueForKey("date") as? String)!+moon+(dictionary.valueForKey("moon") as? String)!
        _weather.weatherLabel.text = info
        
        
        
    }
    
    @IBAction func trainAction(sender: UIButton)
    {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let target = storyboard.instantiateViewControllerWithIdentifier("trainViewController")
        //        self.navigationController?.pushViewController(target, animated:true)
    }
    
    
    
}





