//
//  HistoryViewController.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import Alamofire

class HistoryViewController: UIViewController {

    var teamString:String!
    
    @IBOutlet weak var homebutton: UIButton!
    @IBOutlet weak var teamLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamLabel.text = teamString

        reloadData()
      
    }
  
    @IBAction func homebuttnAction(sender: UIButton)
    {
        let myStoryBoard = self.storyboard
        let anotherView:HomeViewController = myStoryBoard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        self.splitViewController?.showViewController(anotherView, sender: nil)
    }
    func reloadData(){
        


        let string1 = "http://op.juhe.cn/onebox/news/query?q="
        let string2 = "&dtype=&key=c3184060738e9895f1f66bd9af7e1d87"
       
        //URL 中文转码
        let urlString = self.teamString.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        let string3 = string1+urlString!+string2
        
        NetWorkRequest.request("get", url: string3) { (data, response, error) -> Void in
            guard error != nil else{
                
                let string = data.dataUsingEncoding(NSUTF8StringEncoding)
                let jsonDic = try! NSJSONSerialization.JSONObjectWithData(string!,
                                                                          options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
                print(jsonDic?.valueForKey("result"))
                return
            }
        }
 
       
       
        
//        Alamofire.request(.GET, string3).response{(request, response, data, error) in
//           
//            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
//                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
//            print(jsonArr?.valueForKey("result"))
//      
//            
//        }
//        
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
