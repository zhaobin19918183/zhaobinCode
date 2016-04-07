//
//  imageViewController.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/11.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class imageViewController: UIViewController {

    @IBOutlet weak var _toolBar: UIToolbar!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.Plain,target:self,action:#selector(imageViewController.backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        
    }
    
    func backHomeView()
    {

        self.navigationController!.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
        
    }
  

}
