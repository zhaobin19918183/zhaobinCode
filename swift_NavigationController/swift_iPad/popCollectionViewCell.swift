//
//  popCollectionViewCell.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/31.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class popCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImagview: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        // Initialization code
    }
    
  
}
