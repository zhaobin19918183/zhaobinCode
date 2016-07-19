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
    var life                   : NSData?
    var pm25                   : NSData?
    var realtime               : NSData?
    var weather                : NSData?
    
    static func convertFrom(dictionary :WeatherEntity) -> WeatherModel
    {
        var model = WeatherModel()
        model.life                   = dictionary.life
        model.pm25                   = dictionary.pm25
        model.realtime               = dictionary.realtime
        model.weather                = dictionary.weather

        return model
    }
    
    static func searchForm(dictionary :NSMutableDictionary) -> WeatherModel
    {
        var model = WeatherModel()
        model.life                   = dictionary["life"] as? NSData
        model.pm25                   = dictionary["pm25"] as? NSData
        model.realtime               = dictionary["realtime"] as? NSData
        model.weather                = dictionary["realtime"] as? NSData
        
        return model
    }
    

}