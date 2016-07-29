//
//  CSNavTabBar.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class CSNavTabBar: UIView {
    
    private let featherWidth: CGFloat = 45.0    //羽化效果宽
    private let arrowWidth: CGFloat = 40.0  //箭头按钮的宽
    private let titleSpace: CGFloat = 25.0  //标题间距
    private let titlesHeaderWidth: CGFloat = 18.0 //标题栏头部的宽
    private let titlesFooterWidth: CGFloat = 18.0 //标题栏尾部的宽
    private let titleTransformDuration = 0.25   //标题变大、缩小的动画时间

    private let scrollView = UIScrollView() //标题栏
    private let arrowButton = UIButton()    //箭头按钮
    private var titleButtons = [UIButton]() //保存标题按钮的数组
    
    let leftFeatherImageView = UIImageView(image: UIImage(named: "navbar_left_more"))  //左边的羽化效果
    let rightFeatherImageView = UIImageView(image: UIImage(named: "navbar_right_more")) //右边的羽化效果

    //代理
    weak var delegate: CSNavTabBarDelegate?
    
    //当选项少时是否显示合适点的布局 default false
    var decentWhenLess: Bool = false {
        didSet {
            refitTitleButtons()
        }
    }
    
    //普通状态的字体颜色
    var normalTitleColor = norTitleColor {
        didSet {
            for button in titleButtons {
                if titleButtons.indexOf(button) != selectedIndex {
                    button.setTitleColor(normalTitleColor.color, forState: UIControlState.Normal)
                }
            }
        }
    }
    
    //选中状态的字体颜色
    var selectedTitleColor = selTitleColor {
        didSet {
            let button = titleButtons[selectedIndex]
            button.setTitleColor(selectedTitleColor.color, forState: UIControlState.Normal)
        }
    }
    
    //字体
    var font: UIFont = (UIFont(name: "HelveticaNeue", size: 14.0) != nil) ? UIFont(name: "HelveticaNeue", size: 14.0)! : UIFont.systemFontOfSize(14.0) {
        didSet {
            for button in titleButtons {
                button.titleLabel?.font = font
            }
        }
    }
    
    //标题缩放率
    var titleScale: CGFloat = 1.4 {
        didSet {
            if titleScale < 1.0 {
                titleScale = 1.2
            }
            let selectedButton = titleButtons[selectedIndex]
            selectedButton.transform = CGAffineTransformMakeScale(self.titleScale, self.titleScale)
        }
    }
    
    //选中的选项
    var selectedIndex: Int = 0 {
        willSet {
            if newValue != selectedIndex {
                if selectedIndex < titleButtons.count {
                    let oldSelectedButton = titleButtons[selectedIndex]
                    oldSelectedButton.setTitleColor(normalTitleColor.color, forState: UIControlState.Normal)
                    UIView.animateWithDuration(titleTransformDuration) { () -> Void in
                        oldSelectedButton.transform = CGAffineTransformIdentity
                    }
                }
            }
        }
        didSet {
            if selectedIndex != oldValue {
                resetOffsetWithAnimation(true)
                if selectedIndex < titleButtons.count {
                    let selectedButton = titleButtons[selectedIndex]
                    if selectedIndex != oldValue {
                        selectedButton.setTitleColor(selectedTitleColor.color, forState: UIControlState.Normal)
                        UIView.animateWithDuration(titleTransformDuration) { () -> Void in
                            selectedButton.transform = CGAffineTransformMakeScale(self.titleScale, self.titleScale)
                        }
                        
                    }
                }
            }
        }
    }
    
    //设置标题数组
    var titles: [String]? {
        willSet {
            if titles != nil {
                for button in titleButtons {
                    button.removeFromSuperview()
                }
                titleButtons.removeAll()
                self.scrollView.contentSize = CGSizeZero
            }
        }
        didSet {
            if titles != nil {
                
                for i in 0..<titles!.count {
                    let title = titles![i]
                    
                    let button = UIButton(frame: CGRectZero)
                    button.titleLabel?.font = font
                    button.setTitle(title, forState: UIControlState.Normal)
                    button.setTitleColor(normalTitleColor.color, forState: UIControlState.Normal)
                    button.addTarget(self, action: #selector(CSNavTabBar.titleButtonDidClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    button.sizeToFit()
                    
                    if i == selectedIndex {
                        button.setTitleColor(selectedTitleColor.color, forState: UIControlState.Normal)
                        button.transform = CGAffineTransformMakeScale(titleScale, titleScale)
                    }
                    
                    titleButtons.append(button)
                    scrollView.addSubview(button)
                }
                
                refitTitleButtons()
            }
        }
    }

    //设置是否有箭头按钮
    var hasArrow: Bool = true {
        didSet {
            arrowButton.hidden = !hasArrow
            refitUI()
        }
    }

    // MARK: override 重写
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        self.addSubview(scrollView)
        self.addSubview(leftFeatherImageView)
        self.addSubview(rightFeatherImageView)
        
        self.addSubview(arrowButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        refitUI()
    }
    
    // MARK: 初始化UI
    private func configureUI() {
        self.backgroundColor = barBackgroundColor

        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        arrowButton.setImage(UIImage(named: "channel_nav_arrow"), forState: UIControlState.Normal)
        arrowButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01))
        arrowButton.addTarget(self, action: #selector(CSNavTabBar.arrowButtonDidClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        leftFeatherImageView.hidden = true
        refitUI()
    }
    // MARK: 重新布局UI
    func refitUI() {
        if hasArrow {
            scrollView.frame = CGRectMake(0, 0, frame.width - arrowWidth, frame.height)
            arrowButton.frame = CGRectMake(frame.width - arrowWidth, 0, arrowWidth, frame.height)
        } else {
            scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        }
        
        leftFeatherImageView.left = 0
        leftFeatherImageView.centerY = frame.height / 2.0
        rightFeatherImageView.right = scrollView.right
        rightFeatherImageView.centerY = frame.height / 2.0
        
        if titles != nil {
            refitTitleButtons()
        }
    }
    // MARK: 重新设置标题按钮的坐标以及scrollView.contentSize
    private func refitTitleButtons() {
        var contentWidth: CGFloat = titlesHeaderWidth   //记录标题+头尾空隙+标题间距累计宽度
        var allTitleWidth: CGFloat = 0  //记录标题累计宽度
        
        for i in 0..<titles!.count {
            let title = titles![i]
            let titleWidth = (title as NSString).textSizeWithFont(font).width
            allTitleWidth += titleWidth
            contentWidth += (titleWidth + titleSpace)
        }
        contentWidth -= titleSpace
        contentWidth += titlesFooterWidth
        
        
        var newTitleSpace = titleSpace
        var newHeaderWidth = titlesHeaderWidth
        var newFooterWidth = titlesFooterWidth
        var newContentWidth = titlesHeaderWidth
        //若内容宽度小于scrollView的宽度，重新设置标题间距、头尾宽度
        if decentWhenLess && contentWidth < scrollView.width {
            newTitleSpace = (scrollView.width - allTitleWidth) / CGFloat(titles!.count)
            newHeaderWidth = newTitleSpace / 2.0
            newFooterWidth = newTitleSpace / 2.0
            newContentWidth = newHeaderWidth
        }
        for i in 0..<titles!.count {
            let title = titles![i]
            let button = titleButtons[i]
            
            let titleWidth = (title as NSString).textSizeWithFont(font).width
            
            button.centerX = newContentWidth + titleWidth / 2.0   //设置每个按钮的centerX坐标（ps：如果设置x坐标，会导致选中的被放大的按钮坐标不能达到期望的位置）
            button.centerY = scrollView.height / 2.0
            
            newContentWidth += (titleWidth + newTitleSpace)
        }
        newContentWidth -= newTitleSpace
        newContentWidth += newFooterWidth
        self.scrollView.contentSize = CGSizeMake(newContentWidth, self.scrollView.height)
        
        for titleButton in titleButtons {
            titleButton.centerY = scrollView.height / 2.0
            //防止transform后字体变模糊，需设layer.contentsScale
            titleButton.titleLabel?.layer.contentsScale = UIScreen.mainScreen().scale * self.titleScale
        }
    }
    
    // MARK: 获取转场的颜色 scale：比例
    private func transitionColorWithScale(scale: CGFloat) -> UIColor {
        return UIColor(red: normalTitleColor.red + (selectedTitleColor.red - normalTitleColor.red) * scale,
            green: normalTitleColor.green + (selectedTitleColor.green - normalTitleColor.green) * scale,
            blue: normalTitleColor.blue + (selectedTitleColor.blue - normalTitleColor.blue) * scale,
            alpha: normalTitleColor.alpha + (selectedTitleColor.alpha - normalTitleColor.alpha) * scale)
    }
    
    internal func arrowButtonDidClick(sender: UIButton) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            if CGAffineTransformIsIdentity(self.arrowButton.transform) {
                self.arrowButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI - 0.01))
            } else {
                self.arrowButton.transform = CGAffineTransformIdentity
            }
        })
        self.arrowButton.selected = !self.arrowButton.selected
        self.delegate?.navTabBar?(self, didClickArrowButton: sender)
    }
    
    internal func titleButtonDidClick(sender: UIButton) {
        let index = titleButtons.indexOf(sender)
        if self.selectedIndex != index! {
            self.selectedIndex = index!
            self.delegate?.navTabBar?(self, didSelectItemAtIndex: index!)
        }
    }
    // MARK: 重置titles的offset
    internal func resetOffsetWithAnimation(animated: Bool) {
        if selectedIndex < titleButtons.count {
            let selectedButton = titleButtons[selectedIndex]
            var offsetX = selectedButton.centerX - scrollView.width / 2.0
            
            if offsetX > scrollView.contentSize.width - scrollView.width {
                offsetX = scrollView.contentSize.width - scrollView.width
            }
            if offsetX < 0 {
                offsetX = 0
            }
            
            scrollView.setContentOffset(CGPointMake(offsetX, 0.0), animated: animated)
        }
    }
    // MARK: 转场效果（字体大小、颜色转场效果） 占比 leftScale >= 0 && leftScale <= 1
    internal func transitionForLeftIndex(leftIndex: Int, rightIndex: Int, leftScale: CGFloat, rightScale: CGFloat) {
        
        if leftScale >= 0.0 && leftScale <= 1 {
            
            let difrentScale = titleScale - 1.0
            
            let leftButton = titleButtons[leftIndex]
            let rightButton = titleButtons[rightIndex]
            
            let leftButtonScale = 1.0 + difrentScale * leftScale
            let rightButtonScale = 1.0 + difrentScale * rightScale
            
            let leftButtonTitleColor = transitionColorWithScale(leftScale)
            let rightButtonTitleColor = transitionColorWithScale(rightScale)
            
            //改变按钮的大小
            leftButton.transform = CGAffineTransformMakeScale(leftButtonScale, leftButtonScale)
            rightButton.transform = CGAffineTransformMakeScale(rightButtonScale, rightButtonScale)
            //改变按钮字体颜色
            leftButton.setTitleColor(leftButtonTitleColor, forState: UIControlState.Normal)
            rightButton.setTitleColor(rightButtonTitleColor, forState: UIControlState.Normal)
        }
    }
    func resetArrowButton() {
        arrowButtonDidClick(arrowButton)
    }
}
// MARK: extension UIScrollViewDelegate
extension CSNavTabBar: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //羽化效果显示与隐藏
        let contentOffset = scrollView.contentOffset
        let contentWidth = scrollView.contentSize.width
        leftFeatherImageView.hidden = (contentOffset.x < titlesHeaderWidth / 2.0) ? true : false
        rightFeatherImageView.hidden = (contentWidth - contentOffset.x - scrollView.width < titlesFooterWidth / 2.0) ? true : false
    }
}

@objc protocol CSNavTabBarDelegate : NSObjectProtocol {
    optional func navTabBar(navTabBar: CSNavTabBar, didSelectItemAtIndex index: Int)
    optional func navTabBar(navTabBar: CSNavTabBar, didClickArrowButton arrowButton: UIButton)
}

