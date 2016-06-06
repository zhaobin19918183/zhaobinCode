//
//  nameTextField.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/6.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class nameTextField: UITextField,UITextFieldDelegate {

    var textFiedFirst : nameTextField!
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    func resetUILayout()
    {
        textFiedFirst.delegate = self
      
    }
    

}
