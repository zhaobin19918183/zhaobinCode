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


class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate{
    let locationManager:CLLocationManager = CLLocationManager()
    var currLocation:CLLocation = CLLocation()
    
    weak var weatherEntity : WeatherEntity?
    weak var dataDic  = NSMutableDictionary()
    @IBOutlet weak var _weather: WeatherView!
    @IBOutlet weak var _traffic: TrafficView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var progressHUD : MBProgressHUD!
    var imageArray = ["basketball","football","news","wifi.jpg","jiazhao.jpg"]
    var lineString:String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        location()
        weatherCoredata()
        weatherMoreButtonAction()
        trafficViewSearchButtonAction()
        
        _traffic.pickerView = self.parentViewController!
        collectionView.registerNib(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        rxTextFieldCocoa()
        
    }
    
        
    //MARK:CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellID", for: indexPath as IndexPath) as? HomeCollectionViewCell
        if cell == nil
        {
            let nibArray : NSArray = NSBundle.mainBundle().loadNibNamed("HomeCollectionViewCell", owner:self, options:nil)
            cell = nibArray.firstObject as? HomeCollectionViewCell
        }
        cell?.backgroundimagView.image = UIImage(named: imageArray[indexPath.row])
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print(indexPath.row)
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
    //MARK:bus申请数据
    func  alamofireRequestData()
    {
        if self.lineString == nil {
            let okAction:UIAlertAction = UIAlertAction(title: Common_OK, style: UIAlertActionStyle.Default) {
                (action: UIAlertAction!) -> Void in
                self.progressHUD.hide(true, afterDelay:0.25)
            }
            AlertControllerAction(Common_Warning, message: "公交线路输入为空", firstAction:okAction, seccondAction: nil,thirdAction:nil)
            self.progressHUD.hide(true, afterDelay:0)
        }
        else
        {
//            NetWorkManager.alamofireRequestData("大连", bus:self.lineString, url: Common_busUrl)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.successAction), name: "alamofireSuccess", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.errorAction), name: "alamofireError", object: nil)
        
    }
    //MARK:error
    func errorAction()
    {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "alamofireError", object: nil)
        let errorAction:UIAlertAction = UIAlertAction(title: Common_OK, style: UIAlertActionStyle.Default) {
            (action: UIAlertAction!) -> Void in
            self.progressHUD.hide(true, afterDelay:0)
        }
        AlertControllerAction(Common_Warning, message: "公交线路输入错误", firstAction:errorAction, seccondAction: nil,thirdAction:nil)
        
    }
    //MARK:AlertControllerAction
    func AlertControllerAction(title:String , message:String ,firstAction:UIAlertAction,seccondAction:UIAlertAction?,thirdAction:UIAlertAction?)
    {
        
        let alert  = UIAlertController(title:title, message:message, preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(firstAction)
        if seccondAction != nil
        {
            alert.addAction(seccondAction!)
        }
        if thirdAction != nil
        {
            alert.addAction(thirdAction!)
        }
        
        self.presentViewController(alert, animated:true, completion:nil)
    }
    //MARK:successAction
    func successAction()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("busTableViewViewController")
            as! BusTableViewController
        self.progressHUD.hide(true, afterDelay:0.25)
        self.navigationController?.pushViewController(target, animated:true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "alamofireSuccess", object: nil)
        
    }
    //MARK:MBProgressHUD
    func prpgressHud()
    {
        progressHUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progressHUD.labelText = "正在申请数据......"
        //背景渐变效果
        progressHUD.dimBackground = true
    }
    //MARK:moreWeather
    func moreWeather()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("moreWeatherViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    //MARK:netWorkAlert
    
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
    //MARK:weatherAlamofire
    func weatherAlamofire()
    {
        self.prpgressHud()
//        NetWorkManager.alamofireWeatherRequestData("大连", url: "http://op.juhe.cn/onebox/weather/query", key: "e527188bbf687ccccac5350acf9a151f", dtype: "json")
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.weatherData), name: "TimeOut", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.weatherData), name: "WeatherData", object: nil)
        
    }
    
    func weatherData(notification:NSNotification)
    {
        if (notification.object?.localizedDescription == "The request timed out.")
        {
            let errorAction:UIAlertAction = UIAlertAction(title: Common_OK, style: UIAlertActionStyle.Default) {
                (action: UIAlertAction!) -> Void in
                self.progressHUD.hide(true, afterDelay:0)
            }
            AlertControllerAction(Common_Warning, message: "网络申请超时,将使用本地数据!!!!", firstAction:errorAction, seccondAction: nil,thirdAction:nil)
        }
        self.dataFunc()
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"WeatherData", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:"TimeOut", object: nil)
    }
    
    func weatherCoredata()
    {
        let status = Reach().connectionStatus()
        
        if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
            
            if  status.description == "Offline"
            {
                netWorkAlert()
            }
            else
            {
                weatherAlamofire()
            }
        }
        else
        {
            if  status.description == "Offline"
            {
                dataFunc()
            }
            else
            {
                weatherAlamofire()
            }
        }
    }
    
    func  dataFunc()
    {
        self.progressHUD.hide(true, afterDelay:0)
        let weatherModel = WeatherDAO.SearchWeatherModel()
        let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(weatherModel.realtime! )! as! NSDictionary
        _weather.weatherDic(dictionary)

    }
    //MARK: - 地图
    func location()
    {
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        //发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        currLocation = locations.last!
        
        print( "经度：\(currLocation.coordinate.longitude)")
        print( "纬度：\(currLocation.coordinate.latitude)")
        LonLatToCity()
        
    }
    
    ///将经纬度转换为城市名
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            
            if(error == nil)
            {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //城市
                let city: String = (mark.addressDictionary! as NSDictionary).valueForKey("City") as! String
                print((mark.addressDictionary! as NSDictionary).allKeys)
                print(city)
                
            }
            else
            {
                print(error)
            }
        }
    }

}
