//
//  NavigationViewController.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/25.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import Alamofire

class NavigationViewController: UINavigationController {
   
    var titleLabel = UILabel()
    var HUDProgtess = MBProgressHUD()
    
    var count:NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.navigationBar.setBackgroundImage(UIImage(named: "P_NavigationViewController_Bar_1024x64.png"), forBarMetrics: UIBarMetrics.Default)
        
         titleLabel = UILabel(frame: CGRectMake(self.navigationBar.bounds.size.width/3, -20, self.navigationBar.bounds.size.width/3+50, self.navigationBar.bounds.size.height+20))
    
        titleLabel.textColor = UIColor.whiteColor()
        //文字居中
        titleLabel.textAlignment  = NSTextAlignment.Center
        titleLabel.text = "新闻热点"
        self.navigationBar.addSubview(titleLabel)
        reloadData()
        
    }
    func reloadData()
    {
        let BaiduURL = "http://op.juhe.cn/onebox/news/words?dtype=&key=c3184060738e9895f1f66bd9af7e1d87"
        self.defaultShow()
        Alamofire.request(.GET, BaiduURL).response{(request, response, data, error) in
            let jsonArr = try! NSJSONSerialization.JSONObjectWithData(data!,
                options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary
            self.count = jsonArr?.valueForKey("result")?.count
            self.hiddenHUD()
           
            
        }
        
    }
    
    
    func defaultShow(){
        HUDProgtess = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUDProgtess.labelText = "正在同步请稍等....."
        //背景渐变效果
        HUDProgtess.dimBackground = true
       
    }
    func hiddenHUD()
    {
        HUDProgtess.mode = MBProgressHUDMode.CustomView
        HUDProgtess.customView = UIImageView(image: UIImage(named: "yes")!)
        
        HUDProgtess.labelText = "数据请求成功"
        
        //延迟隐藏
        HUDProgtess.hide(true, afterDelay: 1)
    
    }
    
    func textShow(){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = "这是纯文本提示"
        hud.detailsLabelText = "这是详细信息内容，会很长很长呢"
        
        //延迟隐藏
        hud.hide(true, afterDelay: 0.8)
    }
    func customShow(){
        
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = MBProgressHUDMode.CustomView
        hud.customView = UIImageView(image: UIImage(named: "yes")!)
        
        hud.labelText = "这是自定义视图"
        
        //延迟隐藏
        hud.hide(true, afterDelay: 0.8)
    }
    
    func asyncShow(){
        var hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "请稍等，数据加载中,预计10秒中"
        
        hud.showAnimated(true, whileExecutingBlock: {
            //异步任务，在后台运行的任务
            sleep(10)
        }) {
            //执行完成后的操作，移除
            hud.removeFromSuperview()
            hud = nil
        }
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
