
//
//  MyViewController.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/25.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var popButton: UIButton!
     var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func popViewAction(_ sender: UIButton)
    {

        let loginView = popViewController()
        loginView.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.present(loginView, animated: true, completion: nil)

    }




}
