//
//  CSChannelCollectionViewCell.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//


import UIKit

enum CSChannelStatus {
    case normal             //普通状态
    case highlight          //高亮状态
    case editing            //编辑状态
    case simpleNormal       //简单的普通状态
    case simpleHighlight    //简单的高亮状态
    case simpleEditing      //简单的编辑状态
}

class CSChannelCollectionViewCell: UICollectionViewCell {
    let backgroundImageView: UIImageView!
    fileprivate let textLabel: UILabel!
    fileprivate let deleteButton: UIButton!
    
    fileprivate var deleteCallBack: ((CSChannelCollectionViewCell) -> Void)?
    
    
    var text: String? {
        didSet {
            self.textLabel.text = text
            textLabel.sizeToFit()
            textLabel.center = CGPoint(x: self.backgroundImageView.width / 2.0, y: self.backgroundImageView.height / 2.0)
        }
    }
    
    var status: CSChannelStatus = .normal {
        didSet {
            switch status {
            case .normal:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.isHidden = true
            case .highlight:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = selTitleColor.color
                self.deleteButton.isHidden = true
            case .editing:
                self.backgroundImageView.image = UIImage(named: "channel_grid_circle")
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.isHidden = false
            case .simpleNormal:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = norTitleColor.color
                self.deleteButton.isHidden = true
            case .simpleHighlight:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = selTitleColor.color
                self.deleteButton.isHidden = true
            case .simpleEditing:
                self.backgroundImageView.image = nil
                self.textLabel.textColor = disableTitleColor_day.color
                self.deleteButton.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 2, width: 70, height: 30))
        textLabel = UILabel(frame: CGRect.zero)
        deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        super.init(frame: frame)
        
        backgroundImageView.image = UIImage(named: "channel_grid_circle")

        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textColor = norTitleColor.color
        
        deleteButton.setImage(UIImage(named: "channel_edit_delete"), for: UIControlState())
        deleteButton.addTarget(self, action: #selector(CSChannelCollectionViewCell.deleteButtonDidPress(_:)), for: UIControlEvents.touchUpInside)
        deleteButton.isHidden = true
        self.backgroundImageView.addSubview(textLabel)
        self.contentView.addSubview(backgroundImageView)
        self.contentView.addSubview(deleteButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.center = CGPoint(x: self.width / 2.0, y: (self.height - 2) / 2.0 + 2)
    }
    
    // delete点击事件
    internal func deleteButtonDidPress(_ sender: UIButton) {
        self.deleteCallBack?(self)
    }
    // 添加点击事件的回调闭包
    internal func deleteActionCallBack(_ callBack: @escaping ((CSChannelCollectionViewCell) -> Void)) {
        self.deleteCallBack = callBack
    }
    
}

