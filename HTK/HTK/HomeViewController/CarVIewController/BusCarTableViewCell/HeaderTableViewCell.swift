//
//  HeaderTableViewCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/1.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var busNameLabel: UILabel!
    
    @IBOutlet weak var firstStationLabel: UILabel!
    @IBOutlet weak var fitstStationNameLabel: UILabel!
    @IBOutlet weak var endStationLabel: UILabel!
    
    @IBOutlet weak var endStationNameLabel: UILabel!
    
    @IBOutlet weak var firstBusLabel: UILabel!
    @IBOutlet weak var firstBusTimeLabel: UILabel!
    
    @IBOutlet weak var endBusLabel: UILabel!
    @IBOutlet weak var endBusTImeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
