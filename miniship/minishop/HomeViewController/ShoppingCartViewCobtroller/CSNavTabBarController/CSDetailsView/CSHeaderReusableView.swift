//
//  CSHeaderReusableView.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class CSHeaderReusableView: UICollectionReusableView {
    private let textLabel = UILabel(frame: CGRectZero)
    
    var text: String? {
        didSet {
            textLabel.text = text
            textLabel.sizeToFit()
            textLabel.left = 10
            textLabel.centerY = frame.height / 2.0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.left = 10
        textLabel.centerY = frame.height / 2.0
        textLabel.font = UIFont.systemFontOfSize(14)
        self.addSubview(textLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.left = 10
        textLabel.centerY = frame.height / 2.0
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com