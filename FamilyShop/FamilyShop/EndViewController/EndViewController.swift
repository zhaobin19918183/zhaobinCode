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
    
    var EndDic0:NSDictionary!
    var EndDic1:NSDictionary!
    var EndDic:NSDictionary!
    
    var EndArray0:NSArray!
    var EndArray1:NSArray!
    var EndArray:NSMutableArray!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        alamofireRequest()
       
        
        // Do any additional setup after loading the view.
    }
    func  alamofireRequest()
    {
        Alamofire.request("http://op.juhe.cn/onebox/basketball/nba?dtype=&=&key=a77b663959938859a741024f8cbb11ac").responseJSON { (data) in
            let dic = data.result.value  as! [String:AnyObject]
  
            let arr = dic["result"]?["list"] as! NSArray
            self.EndDic0 = arr.object(at: 0) as! NSDictionary
            self.EndArray0 = self.EndDic0.value(forKey: "tr") as! NSArray!
            
            self.EndDic1 = arr.object(at: 1) as! NSDictionary
            self.EndArray1 = self.EndDic1.value(forKey: "tr") as! NSArray!
            
            for  index in 0...self.EndArray1.count - 1
            {
              let dic = self.EndArray1.object(at: index) as! NSDictionary
              let  status = dic.value(forKey: "status") as! NSNumber
                if status == 2
                {
                    
                self.EndArray0.addingObjects(from: [self.EndArray1.object(at: index)])
                    
                }
                
            }
           
            
            self._tableview.reloadData()
    
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if self.EndArray0 == nil
        {
          return 1
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
            cell?.endLiveDicAction(dic: self.EndArray0.object(at: indexPath.row) as! NSDictionary,tableview:tableView)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
