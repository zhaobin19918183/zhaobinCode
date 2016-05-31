//
//  TrafficView.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/17.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class TrafficView:UIView,trafficViewPickerDelegate {

    @IBOutlet var trafficView: UIView!
    var pickerView = UIViewController()
    
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var gongjiaoLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var projectButton: UIButton!
    @IBOutlet weak var lineTextField: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        
        resetUILayout()
        
    }
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("TrafficView", owner:self,options:nil)
        projectButton.hidden = true
        typeButton.tag = 2
        projectButton.tag = 1
        self.addSubview(trafficView)
        
    }
    @IBAction func typeButtonAction(sender: UIButton)
    {
        let loginView = pickerViewController()
        loginView.delegate = self
        loginView.tag = String(sender.tag)
        lineTextField.hidden = false
        lineTextField.placeholder = "线路"
        projectButton.hidden = true
        loginView.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.5)
        pickerView.presentViewController(loginView, animated: true, completion: nil)
    }
    @IBAction func projectButtonAction(sender: UIButton)
    {
        
        let loginView = pickerViewController()
        loginView.delegate = self
        loginView.tag = String(sender.tag)
        loginView.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.5)
        pickerView.presentViewController(loginView, animated: true, completion: nil)
 
    }
    func trafficViewprojectPickerViewString(project: String)
    {
     
         print("project====\(project)")
        if project == "0" {
            projectButton.hidden = true
            lineTextField.hidden = false
            lineTextField.placeholder = "线路"
        }
        else
        if project == "1"
        {
            projectButton.hidden = true
            lineTextField.hidden = false
            lineTextField.placeholder = "站台"
            
        }
        else
        {
            projectButton.hidden = false
            lineTextField.hidden = true
        }
        
        
    }
    func trafficViewtypePickerViewString(type: String)
    {
         print("type====\(type)")
        
        
    }
   
}
