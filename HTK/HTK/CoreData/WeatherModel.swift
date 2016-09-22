//
//  WeatherModel.swift
//  HTK
//
//  Created by Zhao.bin on 16/7/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import Foundation
import UIKit

struct WeatherModel
{
    var life                   : Data?
    var pm25                   : Data?
    var realtime               : Data?
    var weather                : Data?
    
    static func convertFrom(_ dictionary :WeatherEntity) -> WeatherModel
    {
        var model = WeatherModel()
        model.life                   = dictionary.life
        model.pm25                   = dictionary.pm25
        model.realtime               = dictionary.realtime
        model.weather                = dictionary.weather

        return model
    }
    
    static func searchForm(_ dictionary :NSMutableDictionary) -> WeatherModel
    {
        var model = WeatherModel()
        model.life                   = dictionary["life"] as? Data
        model.pm25                   = dictionary["pm25"] as? Data
        model.realtime               = dictionary["realtime"] as? Data
        model.weather                = dictionary["realtime"] as? Data
        
        return model
    }
    

}
