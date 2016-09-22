//
//  typeView.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/15.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class typeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var _typeView: UIView!
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    
    func  resetUILayout()
    {
        
        Bundle.main.loadNibNamed("typeView", owner:self,options:nil)
        self.addSubview(_typeView)
    }


}
