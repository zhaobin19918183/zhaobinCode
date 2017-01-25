//
//  EndViewController.swift
//  NBALive
//
//  Created by Zhao.bin on 16/10/11.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EndViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var _tableview: UITableView!
    
    var EndDic0:[String:AnyObject]!
    var EndDic1:[String:AnyObject]!
    var EndDic:[String:AnyObject]!
    
    var EndArray0:[[String:AnyObject]]!
    var EndArray1:[[String:AnyObject]]!
    var EndArray:NSMutableArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //alamofireRequest()
    }
    override func viewDidAppear(_ animated: Bool)
    {
          alamofireRequest()
    }
    func  alamofireRequest()
    {
        Alamofire.request("http://op.juhe.cn/onebox/basketball/nba?dtype=&=&key=a77b663959938859a741024f8cbb11ac").responseJSON { (data) in
            let dic = data.result.value  as! [String:AnyObject]
  
            let arr = dic["result"]?["list"] as! [[String:AnyObject]]
            self.EndDic0 = arr[0]
            self.EndArray0 = self.EndDic0["tr"] as! [[String:AnyObject]]
            
            self.EndDic1 = arr[1]
            self.EndArray1 = self.EndDic1["tr"] as! [[String:AnyObject]]
            
            
            for  index in 0...self.EndArray1.count - 1
            {
              let  dic = self.EndArray1[index]
              let  status = dic["status"] as! NSNumber
                if status == 2
                {
                self.EndArray0.append( self.EndArray1[index])
                }
                
            }
            self._tableview.reloadData()
    
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if self.EndArray0 == nil
        {
          return 0
        }
        else
        {
         return  self.EndArray0.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let initIdentifier : String = "TableViewCellID"
        var cell : EndTableViewCell? = tableView.dequeueReusableCell(withIdentifier: initIdentifier) as? EndTableViewCell
        if cell == nil
        {
            let nibArray = Bundle.main.loadNibNamed("EndTableViewCell", owner: self, options: nil)
            cell = nibArray?.first as? EndTableViewCell
        }
        if self.EndDic0 != nil
        {
            cell?.endLiveAction(dic: self.EndDic0)
            cell?.endLiveDicAction(dic: self.EndArray0[indexPath.row] ,tableview:tableView)
            cell?.navigationController = self.navigationController
            
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
       
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 260
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
