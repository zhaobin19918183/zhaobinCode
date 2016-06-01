//
//  CarViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/20.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class CarViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var bustableview: UITableView!
    var  navigationItemtitle = String()
    var  detailDic = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "公交"
        self.tabBarController?.tabBar.hidden = true
        let nextItem=UIBarButtonItem(title:" < 返回 ",style:.Plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        busCarPresentationData()
    }
    
    
    
    func busCarPresentationData()
    {
        print(detailDic.valueForKey("result")![0].allKeys)
        
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let initIdentifier : String = "BusCarTableViewCell"
        var cell : BusCarTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? BusCarTableViewCell
        if cell == nil
        {
            let nibArray = NSBundle.mainBundle().loadNibNamed("BusCarTableViewCell", owner: self, options: nil)
            cell = nibArray.first as? BusCarTableViewCell
        }
        cell?.busCarStationdesList(detailDic.valueForKey("result")?.objectAtIndex(indexPath.section).valueForKey("stationdes") as! NSMutableArray, index: indexPath)
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return  60
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return "\(detailDic.valueForKey("result")!.objectAtIndex(section).valueForKey("key_name") as! String )     首班车:\(detailDic.valueForKey("result")!.objectAtIndex(section).valueForKey("start_time") as! String )     末班车:\(detailDic.valueForKey("result")!.objectAtIndex(section).valueForKey("end_time") as! String)  "
            
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("stationdes")?.count)!
        
    }
    //MARK:HeaderTitle
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderTableViewCell") as! HeaderTableViewCell
        headerCell.busNameLabel.text = detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("key_name") as? String
        headerCell.fitstStationNameLabel.text = detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("terminal_name") as? String
        headerCell.endStationNameLabel.text =  detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("front_name") as? String
         headerCell.firstBusTimeLabel.text =  detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("start_time") as? String
        
         headerCell.endBusTImeLabel.text =  detailDic.valueForKey("result")?.objectAtIndex(section).valueForKey("end_time") as? String
        
        
        return headerCell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
        return (detailDic.valueForKey("result")?.count)!
    }
    
    
    
    
}
