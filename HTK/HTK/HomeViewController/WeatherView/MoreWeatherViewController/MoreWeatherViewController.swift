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
    let headerArray = ["当日推荐","天气走势"]
    let titleArray  = ["感冒 : ","空调 : ","穿衣 : ","运动 : ","紫外线 : ","污染 : ","洗车 : "]
    var weatherArr     = NSMutableArray()
    var messageArr0    = NSMutableArray()
    var messageArr1    = NSMutableArray()
    var refreshControl = RefreshControl()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        tabBarControllerData()
        weatherDeatilData()
        tableview.addSubview(refreshControl)

    }
    
    //TODO:赋值
    func  weatherDeatilData()
    {
        self.weatherEntity = WeatherDAO.SearchCoreDataEntity()
        let lifeDictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObject(with: (self.weatherEntity?.value(forKey: "life"))! as! Data)! as! NSDictionary

//        let weatherModel = WeatherDAO.SearchWeatherModel()
//        let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(weatherModel.life! )! as! NSDictionary

        let ganmao = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "ganmao") as! NSArray
        let kongtiao = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "kongtiao") as! NSArray
        let chuanyi = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "chuanyi") as! NSArray
        let yundong = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "yundong") as! NSArray
        let ziwaixian = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "ziwaixian") as! NSArray
        let wuran = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "wuran") as! NSArray
        let xiche = (lifeDictionary.value(forKey: "info") as AnyObject).value(forKey: "xiche") as! NSArray
        self.messageArr1 = [ganmao.object(at: 1),kongtiao.object(at: 1),chuanyi.object(at: 1),yundong.object(at: 1),ziwaixian.object(at: 1),wuran.object(at: 1),xiche.object(at: 1)]
        self.messageArr0 = [ganmao.object(at: 0),kongtiao.object(at: 0),chuanyi.object(at: 0),yundong.object(at: 0),ziwaixian.object(at: 0),wuran.object(at: 0),xiche.object(at: 0)]
        self.weatherArr = NSKeyedUnarchiver.unarchiveObject(with: (self.weatherEntity?.value(forKey: "weather"))! as! Data)! as! NSMutableArray
        
    }
    //TODO:tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if((indexPath as NSIndexPath).section==0)
        {
            let initIdentifier : String = "WaatherTableViewCell"
            var cell : WaatherTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? WaatherTableViewCell
            if cell == nil
            {
                let nibArray = Bundle.main.loadNibNamed("WaatherTableViewCell", owner: self, options: nil)
                cell = nibArray?.first as? WaatherTableViewCell
            }
            cell!.selectionStyle = UITableViewCellSelectionStyle.none
            cell?.infotitle.text = self.titleArray[(indexPath as NSIndexPath).row] + (self.messageArr0[(indexPath as NSIndexPath).row] as! String)
            cell?.messageLabel.text = self.messageArr1[(indexPath as NSIndexPath).row] as? String
            return cell!
        }
        let initIdentifier : String = "MoreTableViewCell"
        var cell : MoreTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? MoreTableViewCell
        if cell == nil
        {
            let nibArray = Bundle.main.loadNibNamed("MoreTableViewCell", owner: self, options: nil)
            cell = nibArray?.first as? MoreTableViewCell
        }
        cell?.weatherDataArray(self.weatherArr, index: indexPath)
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
         
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath as NSIndexPath).section == 0 {
            120
        }
        else
        {
        
        return 240
        
        }
        return  120
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      
        return self.headerArray[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return weatherArr.count
        }
        else{
             return 1
        }
        
      
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
       
        return 2
    }
    func tabBarControllerData()
    {
        self.navigationItem.title = "细说天气"
        self.tabBarController?.tabBar.isHidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem

    }
    //TODO: backHomeView

    func backHomeView()
    {
        
        self.navigationController!.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }

    //TODO:数据刷新
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        tableview.reloadData()
        print("刷新结束")
    }

}
