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
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var directLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    
    func  resetUILayout()
    {
        
        Bundle.main.loadNibNamed("WeatherView", owner:self,options:nil)
        _weatherVIew.backgroundColor = UIColor(patternImage: UIImage(named:"weatherImage.png")!)
        self.addSubview(_weatherVIew)
    }
    func  weatherDic(_ infor:NSDictionary)
    {
        let   windDic = infor.value(forKey: "wind")
        let  weatherDic = infor.value(forKey: "weather")
        let  info = (weatherDic! as AnyObject).value(forKey: "info") as! String
        
        tempratureLabel.text = String(format: "温度 : %@ °",((weatherDic as AnyObject).value(forKey: "temperature") as? String)!)
        let pow = "风力:"
        powerLabel.text = pow+(((windDic as AnyObject).value(forKey: "power"))! as! String)
        let dire = "风向:"
        directLabel.text = dire+(((windDic as AnyObject).value(forKey: "direct"))! as! String)
        let img = UIImage(named:((weatherDic as AnyObject).value(forKey: "img"))! as! String)
        weatherImageView.image = img
        let moon = " 农历 :  "
        dateLabel.text = (infor.value(forKey: "date") as? String)!+moon+(infor.value(forKey: "moon") as? String)!
        weatherLabel.text = info
     
    }
    

    
    
}
