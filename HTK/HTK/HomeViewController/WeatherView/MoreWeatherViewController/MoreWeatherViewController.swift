//
//  MoreWeatherViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/25.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class MoreWeatherViewController: UIViewController {

    weak var weatherEntity : WeatherEntity?
    
    @IBOutlet weak var sctollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarControllerData()
        weatherDeatilData()
        
        
    }
    func tabBarControllerData()
    {
        self.navigationItem.title = "细说天气"
        self.tabBarController?.tabBar.hidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.Plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem

    }
    
    func  weatherDeatilData()
    {
        self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
        
        let lifeDictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("life"))! as! NSData)! as! NSDictionary
        print(lifeDictionary.valueForKey("info")?.allKeys)
        
        let weatherArr:NSMutableArray = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("weather"))! as! NSData)! as! NSMutableArray
        print(weatherArr.count)
        
    }
    
    func backHomeView()
    {
        
        self.navigationController!.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
