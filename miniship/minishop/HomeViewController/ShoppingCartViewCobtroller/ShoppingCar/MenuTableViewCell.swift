//
//  MenuTableViewCell.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/15.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var _menuNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _menuNameLable.layer.borderWidth  = 1
        _menuNameLable.layer.cornerRadius = 5
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
