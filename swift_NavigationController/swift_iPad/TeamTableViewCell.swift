//
//  TeamTableViewCell.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamTileLabel: UILabel!
    @IBOutlet weak var teamImageVIew: UIImageView!
     var  textstring: String?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
