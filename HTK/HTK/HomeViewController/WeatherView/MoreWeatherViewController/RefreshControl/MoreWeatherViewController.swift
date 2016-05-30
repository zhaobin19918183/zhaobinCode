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
    let headerArray = ["当日推荐","未来天气"]
    let titleArray = ["感冒 : ","空调 : ","穿衣 : ","运动 : ","紫外线 : ","污染 : ","洗车 : "]
    var weatherArr  = NSMutableArray()
    var messageArr0  = NSMutableArray()
    var messageArr1  = NSMutableArray()
    /////////////////////////init(coder aDecoder: NSCoder)
    var refreshControl = RefreshControl()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.separatorStyle = UITableViewCellSeparatorStyle.None
        tabBarControllerData()
        weatherDeatilData()
        tableview.addSubview(refreshControl)

      
    }
        
    func  weatherDeatilData()
    {
        self.weatherEntity = WeatherDAO.SearchCoreDataEntity().objectAtIndex(0).objectAtIndex(0) as? WeatherEntity
        
        let lifeDictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("life"))! as! NSData)! as! NSDictionary
        print(lifeDictionary.valueForKey("info")?.allKeys)
        
        
        let ganmao = lifeDictionary.valueForKey("info")?.valueForKey("ganmao") as! NSArray
        let kongtiao = lifeDictionary.valueForKey("info")?.valueForKey("kongtiao") as! NSArray
        let chuanyi = lifeDictionary.valueForKey("info")?.valueForKey("chuanyi") as! NSArray
        let yundong = lifeDictionary.valueForKey("info")?.valueForKey("yundong") as! NSArray
        let ziwaixian = lifeDictionary.valueForKey("info")?.valueForKey("ziwaixian") as! NSArray
        let wuran = lifeDictionary.valueForKey("info")?.valueForKey("wuran") as! NSArray
        let xiche = lifeDictionary.valueForKey("info")?.valueForKey("xiche") as! NSArray
        self.messageArr1 = [ganmao.objectAtIndex(1),kongtiao.objectAtIndex(1),chuanyi.objectAtIndex(1),yundong.objectAtIndex(1),ziwaixian.objectAtIndex(1),wuran.objectAtIndex(1),xiche.objectAtIndex(1)]
        self.messageArr0 = [ganmao.objectAtIndex(0),kongtiao.objectAtIndex(0),chuanyi.objectAtIndex(0),yundong.objectAtIndex(0),ziwaixian.objectAtIndex(0),wuran.objectAtIndex(0),xiche.objectAtIndex(0)]
        self.weatherArr = NSKeyedUnarchiver.unarchiveObjectWithData((self.weatherEntity?.valueForKey("weather"))! as! NSData)! as! NSMutableArray
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        if(indexPath.section==0)
        {
            let initIdentifier : String = "WaatherTableViewCell"
            var cell : WaatherTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? WaatherTableViewCell
            if cell == nil
            {
                let nibArray = NSBundle.mainBundle().loadNibNamed("WaatherTableViewCell", owner: self, options: nil)
                cell = nibArray.first as? WaatherTableViewCell
            }
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell?.infotitle.text = self.titleArray[indexPath.row] + (self.messageArr0[indexPath.row] as! String)
            cell?.messageLabel.text = self.messageArr1[indexPath.row] as? String
            return cell!
        }
        let initIdentifier : String = "MoreTableViewCell"
        var cell : MoreTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? MoreTableViewCell
        if cell == nil
        {
            let nibArray = NSBundle.mainBundle().loadNibNamed("MoreTableViewCell", owner: self, options: nil)
            cell = nibArray.first as? MoreTableViewCell
        }
        
        cell?.weatherDataArray(self.weatherArr, index: indexPath)
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            120
        }
        else
        {
        
        return 160
        
        }
      return  120
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      
        return self.headerArray[section]
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
