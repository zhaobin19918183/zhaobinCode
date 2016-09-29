//
//  TextViewController.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

    var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("text viewDidLoad")
        self.view.backgroundColor = UIColor.orange
        self.view.layer.borderColor = UIColor.green.cgColor
        self.view.layer.borderWidth = 60
        textLabel = UILabel(frame: CGRect.zero)
        textLabel.text = self.title
        textLabel.sizeToFit()
        self.view.addSubview(textLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textLabel.center = CGPoint(x: self.view.width / 2.0, y: self.view.height / 2.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

