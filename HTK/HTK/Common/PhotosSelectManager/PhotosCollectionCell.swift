//
//  PhotosCollectionCell.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class PhotosCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var imageLable: UILabel!
    @IBOutlet weak var backgroundImageVIew: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
      //  print(selected)
        imageLable!.font = UIFont(name: "iconfont", size: 20)
        imageLable!.text = "\u{e614}"
        // Initialization code
        
//        if selected == true {
//            imageLable!.font = UIFont(name: "iconfont", size: 20)
//            imageLable!.text = "\u{e615}"
//        }
//        else
//        {
//            imageLable!.font = UIFont(name: "iconfont", size: 20)
//            imageLable!.text = "\u{e614}"
//        }
    }
    
}
