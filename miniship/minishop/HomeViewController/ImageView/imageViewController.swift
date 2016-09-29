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
        self.tabBarController?.tabBar.isHidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        
    }
    
    func backHomeView()
    {

        self.navigationController!.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
  

}
