//
//  PhotosCollectionViewCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var delectButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        delectButton.layer.cornerRadius = 10
    }

    
}
