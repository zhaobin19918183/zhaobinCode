//
//  MasterViewController.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import Alamofire


class MasterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var Home = HomeViewController()
    var HUDProgtess = MBProgressHUD()
    var  basketballTeamName:NSMutableArray!
    var cellString:String!
    
    override func viewWillAppear(animated: Bool) {
        self.basketballTeamName = NSMutableArray()
        reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.basketballTeamName = NSMutableArray()
        
        
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.basketballTeamName.count != 0) {
            
           return  self.basketballTeamName.count
            
        }
       
        return 0
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIdentifier : String = "TeamTableViewCell"
        var cell : TeamTableViewCell? = tableView.dequeueReusableCellWithIdentifier(initIdentifier) as? TeamTableViewCell
        if cell == nil
        {
            let nibArray = NSBundle.mainBundle().loadNibNamed("TeamTableViewCell", owner: self, options: nil)
            cell = nibArray.first as? TeamTableViewCell
        }
       cell?.teamTileLabel.text = self.basketballTeamName.objectAtIndex(indexPath.row) as?String

        return cell!
    }
    
    func  tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let myStoryBoard = self.storyboard
        let anotherView:HistoryViewController = myStoryBoard?.instantiateViewControllerWithIdentifier("HistoryViewController") as! HistoryViewController
        anotherView.teamString = self.basketballTeamName.objectAtIndex(indexPath.row) as?String
        self.splitViewController?.showViewController(anotherView, sender: nil)

    }
    
    func reloadData(){
        
//        let BaiduURL = "http://op.juhe.cn/onebox/news/words?dtype=&key=c3184060738e9895f1f66bd9af7e1d87"
//        Alamofire.request(.GET, BaiduURL).response{(request, response, data, error) in
//            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
//                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
//            //print(jsonArr?.valueForKey("result")?.valueForKey("title"))
//            self.basketballTeamName = jsonArr?.valueForKey("result") as! NSMutableArray
//            if (self.basketballTeamName.count != 0) {
//                
//                self.tableView.reloadData()
//                
//            }
//
//        }
        
    }
    
    func defaultShow(){
        HUDProgtess = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUDProgtess.labelText = "正在同步请稍等....."
        //背景渐变效果
        HUDProgtess.dimBackground = true
        if (self.basketballTeamName==0) {
            HUDProgtess.hidden = false
        }
        else
        {
            HUDProgtess.hide(true, afterDelay: 0.5)
        }
        //延迟隐藏
        
    }
    
    


}
