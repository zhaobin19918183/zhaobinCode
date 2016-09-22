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
        self.tabBarController?.tabBar.isHidden = true
        let nextItem=UIBarButtonItem(title:" < 返回 ",style:.plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        busCarPresentationData()
    }
    
    
    
    func busCarPresentationData()
    {
        print(detailDic.value(forKey: "result")![0].allKeys)
        
        
    }
    
    func backHomeView()
    {
        
        self.navigationController!.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let initIdentifier : String = "BusCarTableViewCell"
        var cell : BusCarTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? BusCarTableViewCell
        if cell == nil
        {
            let nibArray = Bundle.main.loadNibNamed("BusCarTableViewCell", owner: self, options: nil)
            cell = nibArray?.first as? BusCarTableViewCell
        }
        cell?.busCarStationdesList(detailDic.value(forKey: "result")?.object(at: (indexPath as NSIndexPath).section).value(forKey: "stationdes") as! NSMutableArray, index: indexPath)
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  60
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        
        return "\(((detailDic.value(forKey: "result")! as AnyObject).object(at: section) as AnyObject).value(forKey: "key_name") as! String )     首班车:\(((detailDic.value(forKey: "result")! as AnyObject).object(at: section) as AnyObject).value(forKey: "start_time") as! String )     末班车:\(((detailDic.value(forKey: "result")! as AnyObject).object(at: section) as AnyObject).value(forKey: "end_time") as! String)  "
            
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ((((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "stationdes") as AnyObject).count)!
        
    }
    //MARK:HeaderTitle
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        headerCell.busNameLabel.text = ((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "key_name") as? String
        headerCell.fitstStationNameLabel.text = ((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "terminal_name") as? String
        headerCell.endStationNameLabel.text =  ((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "front_name") as? String
         headerCell.firstBusTimeLabel.text =  ((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "start_time") as? String
        
         headerCell.endBusTImeLabel.text =  ((detailDic.value(forKey: "result") as AnyObject).object(at: section) as AnyObject).value(forKey: "end_time") as? String
        
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return ((detailDic.value(forKey: "result") as AnyObject).count)!
    }
    
    
    
    
}
