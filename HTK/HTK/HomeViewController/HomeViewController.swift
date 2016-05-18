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

class HomeViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    var currLocation:CLLocation = CLLocation()
    weak var weatherEntity : WeatherEntity?
    @IBOutlet weak var _weather: WeatherView!
    
    @IBOutlet weak var _newsVIew: TrafficView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        weather()
//        print(WeatherDAO.SearchCoreDataEntity().objectAtIndex(0))
//        self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0) as? WeatherEntity
//        
//        print(self.weatherEntity?.realtime)
       
        
    }
    
    func weather()
    {
    
        let string1 = "http://op.juhe.cn/onebox/weather/query?cityname="
        let string2 = "&dtype=&key=e527188bbf687ccccac5350acf9a151f"
        let string = "大连"
        let urlString = string.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let string3 = string1+urlString!+string2
        Alamofire.request(.GET, string3).response{(request, response, data, error) in
            
            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
            print(jsonArr?.valueForKey("result")?.valueForKey("data")?.allKeys)
            if(jsonArr != nil)
            {
             WeatherDAO.createNewPassWordData(jsonArr!)
            }
            
        }
        
    }
    
    
    
    func location()
    {
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
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
                print(mark.addressDictionary)
                print(city)
                
            }
            else
            {
                print(error)
            }
        }
    }
    
}





