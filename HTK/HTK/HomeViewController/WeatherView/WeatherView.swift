//
//  WeatherView.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/17.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class WeatherView: UIView
{

    @IBOutlet var _weatherVIew: UIView!
    
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("WeatherView", owner:self,options:nil)
        self.addSubview(_weatherVIew)
        
    }

    
    
}
