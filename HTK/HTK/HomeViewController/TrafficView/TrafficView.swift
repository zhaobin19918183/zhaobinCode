//
//  TrafficView.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/17.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class TrafficView:UIView,trafficViewPickerDelegate,UITextFieldDelegate {
    
    @IBOutlet var trafficView: UIView!
    var pickerView = UIViewController()
    var busString:String!
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
        //请求地址：http://op.juhe.cn/189/bus/busline
        //请求参数：dtype=&city=%E5%A4%A7%E8%BF%9E&bus=3&key=f572b98772d02d5b4ec1164e8b6fb0f0
        resetUILayout()
        
    }
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("TrafficView", owner:self,options:nil)
        projectButton.hidden = true
        typeButton.tag = 2
        projectButton.tag = 1
        lineTextField.delegate = self
        self.addSubview(trafficView)
        
        cityLabel.text = "大连"
        
        
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidEndEditing(textField:UITextField)
    {
        //收起键盘
        //textField.resignFirstResponder()
        self.busString = textField.text
        //打印出文本框中的值
        print(textField.text)
        
    }
    //TODO:
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
        
        print("查询方式====\(project)")
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
        print("换乘方案====\(type)")
        
        
    }
    
}
