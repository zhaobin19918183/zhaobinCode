//
//  BusCarTableViewCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/1.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class BusCarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberDetailLabel: UILabel!

    @IBOutlet weak var nameDetailLabel: UILabel!
    var stationArray = NSMutableArray()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func busCarStationdesList(_ array : NSMutableArray ,index:IndexPath)
    {

        numberDetailLabel.text = (array.object(at: (index as NSIndexPath).row) as AnyObject).value(forKey: "stationNum") as? String
        nameDetailLabel.text = (array.object(at: (index as NSIndexPath).row) as AnyObject).value(forKey: "name") as? String
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
