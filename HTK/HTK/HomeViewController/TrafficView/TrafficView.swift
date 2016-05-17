//
//  TrafficView.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/17.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class TrafficView: UIView {

    @IBOutlet var trafficView: UIView!
  
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
        self.addSubview(trafficView)
        
    }
}
