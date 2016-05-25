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
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var directLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
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
        _weatherVIew.backgroundColor = UIColor(patternImage: UIImage(named:"weatherImage.png")!)
        self.addSubview(_weatherVIew)
        
  
        
    }


    
    
}
