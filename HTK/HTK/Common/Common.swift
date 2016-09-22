//
//  Common.swift
//  EveryOne
//
//  Created by Zhao.bin on 16/1/12.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import Foundation
import UIKit

//Colors
let systemColorClear : UIColor = UIColor.clear
let SystemColorGreen : UIColor = UIColor(red: 76/255.0, green: 217/255.0, blue: 100/255.0, alpha: 1)
let SystemColorGray : UIColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1)
let SystemColorLightRed : UIColor = UIColor(red: 220/255.0, green: 100/255.0, blue: 80/255.0, alpha: 1)
let SystemColorRed : UIColor = UIColor(red: 250/255.0, green: 100/255.0, blue: 80/255.0, alpha: 1)
let SystemColorLightBlack : UIColor = UIColor(red: 100/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1)
let SystemColorBlue : UIColor = UIColor(red: 90/255.0, green: 185/255.0, blue: 230/255.0, alpha: 1)
let SystemColorLightWhite : UIColor = UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)

//Paths
//Level - 1
private let kPathRootArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
let kPathRoot = kPathRootArray[0] as String

//Level - 2
let kPathCoreData = kPathRoot + "/Coredata"

//Level - 3
let kPathSQLITE = kPathCoreData + "/Model.Sqlite"

let Common_busUrl = "http://op.juhe.cn/189/bus/busline"
let Common_OK = " 确认"
let Common_Warning = "警告"
