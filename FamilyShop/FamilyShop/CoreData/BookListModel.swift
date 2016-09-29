//
//  BookListModel.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import Foundation
import UIKit

struct BookListModel {
    
    var name    :String?
    var date    :String?
    var number  :String?
    
    static func converForm(_ dictionary : BookListEntity)->BookListModel
    {
       var  model        = BookListModel()
            model.name   = dictionary.name
            model.date   = dictionary.date
            model.number = dictionary.number
    
       return model
    }
    
    
    
    
}
