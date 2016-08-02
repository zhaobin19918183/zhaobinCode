

import UIKit

class CSEditBar: UIView {

    private let titleLabel = UILabel(frame: CGRectZero)
    let editButton = UIButton(frame: CGRectZero)
    
    weak var delegate: CSEditBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = barBackgroundColor
        
        titleLabel.text = "切换栏目"
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.sizeToFit()
        titleLabel.left = 10
        titleLabel.centerY = frame.height / 2.0
        
        editButton.setTitle("排序删除", forState: UIControlState.Normal)
        editButton.setTitle("完成", forState: UIControlState.Selected)
        editButton.setTitleColor(selTitleColor.color, forState: UIControlState.Normal)
        editButton.setTitleColor(barBackgroundColor, forState: UIControlState.Highlighted)
        editButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        editButton.setBackgroundImage(UIImage(named: "channel_edit_button_bg"), forState: UIControlState.Normal)
        editButton.setBackgroundImage(UIImage(named: "channel_edit_button_selected_bg"), forState: UIControlState.Highlighted)
        editButton.size = CGSizeMake(60, 36)
        editButton.right = self.width - 14
        editButton.centerY = frame.height / 2.0
        editButton.addTarget(self, action: #selector(CSEditBar.editButtonDidPress(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(titleLabel)
        self.addSubview(editButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.left = 10
        titleLabel.centerY = self.height / 2.0
        
        editButton.right = self.width - 14
        editButton.centerY = self.height / 2.0
    }
    
    internal func editButtonDidPress(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            self.delegate?.editBarDidBeginEditing?(self)
        } else {
            self.delegate?.editBarDidFinishEditing?(self)
        }
    }

}

@objc protocol CSEditBarDelegate : NSObjectProtocol {
    optional func editBarDidBeginEditing(editBar: CSEditBar)
    optional func editBarDidFinishEditing(editBar: CSEditBar)
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com