//
//  HomeViewController.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/25.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import  Result
import Alamofire

class HomeViewController: UIViewController,UIPopoverPresentationControllerDelegate,popViewControllerDelegate {
    
    
    @IBOutlet weak var textImageVIew: UIImageView!
    @IBOutlet weak var popbutton: UIButton!
    var HUDProgtess = MBProgressHUD()
    var delegate : popViewControllerDelegate!
    let BaiduURL = "http://apis.haoservice.com/lifeservice/cook/query?"
    var  basketballTeamName:NSMutableArray!
    
    var progressView: UIProgressView!
    var remainTime = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressAction()
    
        
    }
    
    
    func  progressAction()
    {
        // 初始化 progressView
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
        progressView.frame = CGRectMake(self.view.frame.width/2 - 50, 200, 300, 100)
        // 设置初始值
        progressView.progress = 1.0
        // 设置进度条颜色
        progressView.progressTintColor = UIColor.blueColor()
        // 设置进度轨迹颜色
        progressView.trackTintColor = UIColor.greenColor()
        // 扩展：可以通过 progressImage、trackImage 属性自定义出个性进度条
        self.view.addSubview(progressView)
        reloadData()
    }
    func reloadData()
    {

        
        let url = "http://img2.imgtn.bdimg.com/it/u=1457437487,655486635&fm=11&gp=0.jpg"
        
        AlamofireView.alamofireDelegate(url, complete: { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
            
            let percent = totalBytesRead*100/totalBytesExpectedToRead
            self.remainTime   = self.remainTime - Int(percent)
            self.progressView.setProgress(Float(self.remainTime)/100, animated:true)
            print("已下载：\(totalBytesRead)  当前进度：\(percent)%")
            
        })
//            { (request, response, data, error) in
//            
//            let fileManager = NSFileManager.defaultManager()
//            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory,
//                                                            inDomains: .UserDomainMask)[0]
//            let pathComponent = response!.suggestedFilename
//            print(directoryURL.URLByAppendingPathComponent(pathComponent!))
//            print(response)
//            
//        }
        
        
        
        
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
        
        HUDProgtess.labelText = "这是自定义视图"
        
        //延迟隐藏
        HUDProgtess.hide(true, afterDelay: 1)
        
    }
    //MARK:popViewControllerDelegate
    @IBAction func popobuttonAction(sender: UIButton)
    {
        popViewController.collectionSeletctNmuber(10)
        
        let pop = popViewController()
        
        pop.delegate = self
        pop.modalPresentationStyle = .Popover
        pop.popoverPresentationController?.delegate = self
        pop.popoverPresentationController?.sourceView = popbutton
        pop.popoverPresentationController?.sourceRect = CGRectZero
        pop.popoverPresentationController?.sourceRect = popbutton.bounds
        pop.preferredContentSize = CGSizeMake(300, 400)
        pop.popoverPresentationController?.permittedArrowDirections = .Up
        self.presentViewController(pop, animated: true, completion: nil)
    }
    
    
    func popViewControllerPhotosArray(photosImage: UIImage) {
        self.textImageVIew.image = photosImage
        print(photosImage)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func toJSONString(dict:NSMutableDictionary!)->NSString{
        
        let data = try?NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson=NSString(data: data!, encoding: NSUTF8StringEncoding)
        return strJson!
        
    }
    
}
/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


