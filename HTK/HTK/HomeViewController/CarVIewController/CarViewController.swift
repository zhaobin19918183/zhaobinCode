//
//  CarViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/20.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "汽车"
        self.tabBarController?.tabBar.hidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.Plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
