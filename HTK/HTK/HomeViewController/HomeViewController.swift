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
    
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    //var _weatherView
    override func viewDidLoad()
    {
        super.viewDidLoad()
        weatherCoredata()
        weatherMoreButtonAction()
        
        
    }
    func weatherMoreButtonAction()
    {
        _weather.moreButton.addTarget(self, action:#selector(HomeViewController.moreWeather), forControlEvents: UIControlEvents.TouchDown)
    }
    func moreWeather()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("moreWeatherViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    
    func weatherCoredata()
    {
        if(WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).count == 0)
        {
            if (!(NSUserDefaults.standardUserDefaults().boolForKey("everLaunched"))) {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey:"everLaunched")
                let status = Reach().connectionStatus()
                switch status {
                case .Unknown, .Offline:
                    netWorkAlert()
                case .Online(.WWAN):
                    weatherAlamofire()
                case .Online(.WiFi):
                    weatherAlamofire()
                    
                }
                
            }
  
        }
            
        else
        {
            let status = Reach().connectionStatus()
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
            let dataDic = jsonArr?.valueForKey("result")?.valueForKey("data") as!NSMutableDictionary
            
            self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
            let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("realtime"))! as! NSData)! as! NSDictionary
            let dateString = dictionary.valueForKey("date") as? String
            let dateDicString = dataDic.valueForKey("realtime")?.valueForKey("date") as? String
            if(dateString == dateDicString)
            {
                  self.dataFunc()
            }
            else
            {
               WeatherDAO.deleteEntityWith(Entity: self.weatherEntity!)
               WeatherDAO.createNewPassWordData(dataDic)
               self.dataFunc()
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
        let moon = " 农历 : "
        _weather.dateLabel.text = (dictionary.valueForKey("date") as? String)!+moon+(dictionary.valueForKey("moon") as? String)! + info
        
    }
    
    @IBAction func trainAction(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("trainViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    @IBAction func carAction(sender: UIButton)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let target = storyboard.instantiateViewControllerWithIdentifier("carViewController")
        self.navigationController?.pushViewController(target, animated:true)
    }
    
    
}





