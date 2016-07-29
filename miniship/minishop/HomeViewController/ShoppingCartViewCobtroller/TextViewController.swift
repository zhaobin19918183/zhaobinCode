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
        self.view.backgroundColor = UIColor.orangeColor()
        self.view.layer.borderColor = UIColor.greenColor().CGColor
        self.view.layer.borderWidth = 60
        textLabel = UILabel(frame: CGRectZero)
        textLabel.text = self.title
        textLabel.sizeToFit()
        self.view.addSubview(textLabel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textLabel.center = CGPointMake(self.view.width / 2.0, self.view.height / 2.0)
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

