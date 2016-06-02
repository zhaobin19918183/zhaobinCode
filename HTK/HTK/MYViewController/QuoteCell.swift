//
//  QuoteCell.swift
//  表格动画手势示例
//
//  Created by Semper Idem on 14-10-22.
//  Copyright (c) 2014年 星夜暮晨. All rights reserved.
//

import UIKit

class QuoteCell: UITableViewCell {
    
    @IBOutlet var quotationTextView: UITextView!
    
    @IBOutlet weak var stationsNameDetail: UILabel!
    @IBOutlet weak var stationsNumberDetail: UILabel!
    @IBOutlet weak var stationsName: UILabel!
    @IBOutlet weak var stationsNumber: UILabel!
    var quotation: Quotation!
    
    var longPressRecognizer: UILongPressGestureRecognizer?
    
    // 设置语录
    func setTheQuotation(newQuotation: Quotation) {
        
        quotation = newQuotation
        stationsNumberDetail.text = quotation.stationNum
        stationsNameDetail.text = quotation.name
            
      
    }
    
    // 长按手势判定
    func setTheLongPressRecognizer(newLongPressRecognizer: UILongPressGestureRecognizer?) {
            
        if longPressRecognizer != nil {
            self.removeGestureRecognizer(longPressRecognizer!)
        }
        
        if newLongPressRecognizer != nil {
            self.addGestureRecognizer(newLongPressRecognizer!)
        }
            
        longPressRecognizer = newLongPressRecognizer
    }
    
}
