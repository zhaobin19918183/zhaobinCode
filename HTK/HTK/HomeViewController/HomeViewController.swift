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

class HomeViewController: UIViewController{
    

    weak var weatherEntity : WeatherEntity?
    @IBOutlet weak var _weather: WeatherView!
    
    @IBOutlet weak var _newsVIew: TrafficView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        weatherCoredata()
    }
    func weatherCoredata()
    {
        if(WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).count == 0)
        {
          weatherAlamofire()
        }
        else
        {
            self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
            let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("realtime"))! as! NSData)! as! NSDictionary
            print(dictionary.allKeys)
        }
    }
    
    func weatherAlamofire()
    {
    
        let string1 = "http://op.juhe.cn/onebox/weather/query?cityname="
        let string2 = "&dtype=&key=e527188bbf687ccccac5350acf9a151f"
        let string = "大连"
        let urlString = string.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let string3 = string1+urlString!+string2
        Alamofire.request(.GET, string3).response{(request, response, data, error) in
            
            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
            let dataDic = jsonArr?.valueForKey("result")?.valueForKey("data") as!NSMutableDictionary
    
            WeatherDAO.createNewPassWordData(dataDic)
        
            
        }
        
    }
    

    
}





