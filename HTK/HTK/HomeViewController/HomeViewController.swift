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
    }
    func weatherCoredata()
    {
        /*"weather":{
         "humidity":"74",
         "img":"3",
         "info":"阵雨",
         "temperature":"18"*/
        if(WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).count == 0)
        {
             weatherAlamofire()
        }
        else
        {
            self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
            let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("realtime"))! as! NSData)! as! NSDictionary
            let windDic = dictionary.valueForKey("wind")
            let  weatherDic = dictionary.valueForKey("weather")
            let temp = "°"
            _weather.tempratureLabel.text =  (weatherDic?.valueForKey("temperature") as? String)!+temp
            let pow = "风力:"
            _weather.powerLabel.text = pow+((windDic?.valueForKey("power"))! as! String)
            let dire = "风向:"
            _weather.directLabel.text = dire+((windDic?.valueForKey("direct"))! as! String)
            let img = UIImage(named:(weatherDic?.valueForKey("img"))! as! String)
            _weather.weatherImageView.image = img
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





