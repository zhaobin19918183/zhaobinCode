//
//  WaatherTableViewCell.swift
//  HTK
//
//  Created by 赵斌 on 16/5/25.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class WaatherTableViewCell: UITableViewCell {

    @IBOutlet weak var infotitle: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
