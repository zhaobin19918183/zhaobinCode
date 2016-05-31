//
//  pickerViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/31.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

protocol trafficViewPickerDelegate
{
    func trafficViewtypePickerViewString(type:String)
    func trafficViewprojectPickerViewString(project:String)
   
}

class pickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var delegate :trafficViewPickerDelegate!
    @IBOutlet weak var pickerView: UIPickerView!
    var tag:String!
    var projectArr = ["公交线路查询","公交站台经网车辆查询","公交线路换乘方案"]
    var typeArr =   ["0 快捷模式","1 暂无","2 最少换乘模式","3 最少步行模式","4 最舒适模式","5 纯地铁模式"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // print(self.delegate)
        self.modalPresentationStyle = .Custom
       
    }
    
    
    func numberOfComponentsInPickerView( pickerView: UIPickerView) -> Int{
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        if(tag == "1")
        {
          return 6
        }
        else
        {
          return 3
        }
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            if(tag == "1")
            {
                return String(typeArr[row])
            }
            else
            {
                return String(projectArr[row])
            }
            
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        UIView.animateWithDuration(0.5) { () -> Void in
            self.dismissViewControllerAnimated(true) { () -> Void in
                if(self.tag == "1")
                {
                    self.delegate.trafficViewtypePickerViewString(String(row))
                }
                else
                {
                  self.delegate.trafficViewprojectPickerViewString(String(row))
                }
                
            }
        }

        
       // print(row)
    
    }
    
    func dismiss()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    

}
