//
//  WaatherTableViewCell.swift
//  HTK
//
//  Created by 赵斌 on 16/5/25.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class WaatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherBackgroundView: UIView!
    @IBOutlet weak var infotitle: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        weatherBackgroundView.layer.cornerRadius = 10;//设置那个圆角的有多圆
        
       
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

       
    }
    
}
