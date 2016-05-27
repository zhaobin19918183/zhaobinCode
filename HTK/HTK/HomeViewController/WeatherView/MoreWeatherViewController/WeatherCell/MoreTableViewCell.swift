//
//  MoreTableViewCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/26.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /*				"date":"2016-05-29",
					"info":{
     "dawn":[
     "1",
     "多云",
     "17",
     "西南风",
     "4-5 级",
     "19:10"
     ],
     "night":[
     "0",
     "晴",
     "17",
     "西南风",
     "4-5 级",
     "19:11"
     ],
     "day":[
     "1",
     "多云",
     "26",
     "北风",
     "4-5 级",
     "04:31"
     ]
					},
					"week":"日",
					"nongli":"四月廿三"*/
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func weatherDataArray(weather:NSMutableArray ,index:NSIndexPath)
    {
//        if index.row == 0 {
//            
//        }
//        else
//        {
//        
//        }
      print(weather.count)
    }
    
}
