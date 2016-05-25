//
//  MoreWeatherViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/25.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class MoreWeatherViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    weak var weatherEntity : WeatherEntity?
    let titleArray = ["当日推荐","未来天气"]
    var weatherArr  = NSMutableArray()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarControllerData()
        weatherDeatilData()
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier : String = "WaatherTableViewCell"
        var cell : WaatherTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? WaatherTableViewCell
        if cell == nil
        {
            let nibArray = NSBundle.mainBundle().loadNibNamed("WaatherTableViewCell", owner: self, options: nil)
            cell = nibArray.first as? WaatherTableViewCell
            
        }
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            80
        }
        else
        {
        
        return 160
        
        }
      return  80
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      
        return self.titleArray[section]
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return weatherArr.count
        }
        else{
          return 1
        }
        
      
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
       
        return 2
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
        
        self.weatherArr = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("weather"))! as! NSData)! as! NSMutableArray
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
