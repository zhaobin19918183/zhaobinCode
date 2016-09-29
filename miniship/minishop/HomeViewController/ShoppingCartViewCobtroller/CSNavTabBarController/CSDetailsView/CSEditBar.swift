

import UIKit

class CSEditBar: UIView {

    fileprivate let titleLabel = UILabel(frame: CGRect.zero)
    let editButton = UIButton(frame: CGRect.zero)
    
    weak var delegate: CSEditBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = barBackgroundColor
        
        titleLabel.text = "切换栏目"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.sizeToFit()
        titleLabel.left = 10
        titleLabel.centerY = frame.height / 2.0
        
        editButton.setTitle("排序删除", for: UIControlState())
        editButton.setTitle("完成", for: UIControlState.selected)
        editButton.setTitleColor(selTitleColor.color, for: UIControlState())
        editButton.setTitleColor(barBackgroundColor, for: UIControlState.highlighted)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        editButton.setBackgroundImage(UIImage(named: "channel_edit_button_bg"), for: UIControlState())
        editButton.setBackgroundImage(UIImage(named: "channel_edit_button_selected_bg"), for: UIControlState.highlighted)
        editButton.size = CGSize(width: 60, height: 36)
        editButton.right = self.width - 14
        editButton.centerY = frame.height / 2.0
        editButton.addTarget(self, action: #selector(CSEditBar.editButtonDidPress(_:)), for: UIControlEvents.touchUpInside)
        
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
    
    internal func editButtonDidPress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.delegate?.editBarDidBeginEditing?(self)
        } else {
            self.delegate?.editBarDidFinishEditing?(self)
        }
    }

}

@objc protocol CSEditBarDelegate : NSObjectProtocol {
    @objc optional func editBarDidBeginEditing(_ editBar: CSEditBar)
    @objc optional func editBarDidFinishEditing(_ editBar: CSEditBar)
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
