//
//  AppDelegate.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/26.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var button:UIButton?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        initialDirectories()
        self.perform(#selector(AppDelegate.setNew), with: nil, afterDelay:0.25)
        self.window?.makeKeyAndVisible()
        return true
    }
    func setNew()
    {
        
        button = UIButton(type:.contactAdd)
        //设置按钮位置和大小
        button?.frame = CGRect(x:(self.window?.bounds.size.width)! - 100, y:(self.window?.bounds.size.height)! - 150, width:60, height:60)
        //设置按钮文字
        button?.backgroundColor = UIColor.red
        button?.addTarget(self, action: #selector(AppDelegate.test), for: UIControlEvents.touchDown)
//        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(AppDelegate.handlePanGesture(sender:)))
//        button?.addGestureRecognizer(panGesture)
        window?.addSubview(button!)
        
    }
    func test()
    {
        print("1111")
    }
    //拖手势
    func handlePanGesture(sender: UIPanGestureRecognizer){
//        //得到拖的过程中的xy坐标
        var translation : CGPoint = sender.translation(in: button)
        //平移图片CGAffineTransformMakeTranslation
    
        button?.transform = CGAffineTransform(translationX: translation.x+translation.x, y: translation.y+translation.y)
        
        if sender.state == UIGestureRecognizerState.ended{
            translation.x += translation.x
            translation.y += translation.y
        }
     
        
        
    }
 
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

