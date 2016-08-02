//
//  CSChannelCollectionViewCell.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//


import UIKit

enum CSChannelStatus {
    case Normal             //普通状态
    case Highlight          //高亮状态
    case Editing            //编辑状态
    case SimpleNormal       //简单的普通状态
    case SimpleHighlight    //简单的高亮状态
    case SimpleEditing      //简单的编辑状态
}

class CSChannelCollectionViewCell: UICollectionViewCell {
    let backgroundImageView: UIImageView!
    private let textLabel: UILabel!
    private let deleteButton: UIButton!
    
    private var deleteCallBack: ((CSChannelCollectionViewCell) -> Void)?
    
    
    var text: String? {
        didSet {
            self.textLabel.text = text
            textLabel.sizeToFit()
            textLabel.center = CGPointMake(self.backgroundImageView.width / 2.0, self.backgroundImageView.height / 2.0)
        }
    }
    
    var status: CSChannelStatus = .Normal {
        didSet {
            switch status {
            case .Normal:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.hidden = true
            case .Highlight:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = selTitleColor.color
                self.deleteButton.hidden = true
            case .Editing:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.hidden = false
            case .SimpleNormal:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.hidden = true
            case .SimpleHighlight:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = selTitleColor.color
                self.deleteButton.hidden = true
            case .SimpleEditing:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = disableTitleColor_day.color
                self.deleteButton.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        backgroundImageView = UIImageView(frame: CGRectMake(0, 2, 70, 30))
        textLabel = UILabel(frame: CGRectZero)
        deleteButton = UIButton(frame: CGRectMake(0, 0, 14, 14))
        super.init(frame: frame)
        
        backgroundImageView.image = UIImage(named: "channel_grid_circle")

        textLabel.font = UIFont.systemFontOfSize(15)
        textLabel.textColor = norTitleColor.color
        
        deleteButton.setImage(UIImage(named: "channel_edit_delete"), forState: UIControlState.Normal)
        deleteButton.addTarget(self, action: #selector(CSChannelCollectionViewCell.deleteButtonDidPress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        deleteButton.hidden = true
        self.backgroundImageView.addSubview(textLabel)
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(deleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.center = CGPointMake(self.width / 2.0, (self.height - 2) / 2.0 + 2)
    }
    
    // delete点击事件
    internal func deleteButtonDidPress(sender: UIButton) {
        self.deleteCallBack?(self)
    }
    // 添加点击事件的回调闭包
    internal func deleteActionCallBack(callBack: ((CSChannelCollectionViewCell) -> Void)) {
        self.deleteCallBack = callBack
    }
    
}

