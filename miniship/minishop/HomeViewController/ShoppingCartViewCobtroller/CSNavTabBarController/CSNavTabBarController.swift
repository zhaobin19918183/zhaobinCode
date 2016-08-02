

import Foundation
import UIKit

//方便获取rgba值
struct CSRGBColor {
    internal var red: CGFloat
    internal var green: CGFloat
    internal var blue: CGFloat
    internal var alpha: CGFloat
    internal var color: UIColor
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

let barBackgroundColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
let norTitleColor = CSRGBColor(red: 71.0/255.0, green:  71.0/255.0, blue:  71.0/255.0, alpha: 1)    //普通标题颜色
let selTitleColor = CSRGBColor(red: 223.0/255.0, green: 70.0/255.0, blue: 73.0/255.0, alpha: 1) //默认-选中标题颜色
let disableTitleColor_day = CSRGBColor(red: 180.0/255.0, green: 180.0/255.0, blue: 180.0/255.0, alpha: 1) //默认-不可用标题颜色
//更多栏目的背景颜色
let detailsBackgroundColor = UIColor(white: 1, alpha: 0.95)
let headerBackgroundColor = UIColor(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1)

class CSNavTabBarController: UIViewController, UIGestureRecognizerDelegate {
    
    private let navTabBarHeight: CGFloat = 40.0  //bar默认高度
    private let animationDuration: Double = 0.25   //动画时长
    private let channelScale: CGFloat = 1.2    //移动时选项放大的倍数
    
    private var longPressGesture: UILongPressGestureRecognizer!
    private var isAnimating: Bool = false   //记录是否在动画过程
    private var selectedCell: CSChannelCollectionViewCell!    //选中要移动的cell
    private var movingCell: CSChannelCollectionViewCell! //正在移动的cell
    
    
    private var myViewControllers = [UIViewController]()    //我的频道
    
    private(set) var navTabBar: CSNavTabBar!   //导航tabBar
    private(set) var containerScrollView: UIScrollView!    //容器scrollView
    private(set) var editBar: CSEditBar!    //下拉列表时显示的编辑bar
    private(set) var collectionView: CSChannelCollectionView! //编辑tabBar的下拉列表
    
    
    //是否正在编辑
    private(set) var channelEditing: Bool = false {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var saveChange:Bool! = false
    var moreViewControllers = [UIViewController]()  //未添加的controller
    
    //展示的的controller
    var viewControllers = [UIViewController]() {
        didSet {
            self.changeViewControllers(oldValue, toViewControllers: viewControllers)
        }
    }
    
    //不可编辑、删除的选项数
    var disabledCount: Int = 0 {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        refitUI()
    }
    
    // MARK: private method
    private func configureUI() {
        
        containerScrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.width, self.view.height))
        containerScrollView.contentInset = UIEdgeInsetsMake(containerScrollView.contentInset.top + navTabBarHeight, containerScrollView.contentInset.left, 0, containerScrollView.contentInset.right)
        containerScrollView.contentSize = CGSizeMake(containerScrollView.width * CGFloat(viewControllers.count), containerScrollView.height - containerScrollView.contentInset.top)
        containerScrollView.delegate = self
        containerScrollView.pagingEnabled = true
        containerScrollView.showsHorizontalScrollIndicator = false

        let collectionViewHeight = containerScrollView.contentSize.height
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(70, 30)
        flowLayout.minimumLineSpacing = 17
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsetsMake(17, 13, 17, 13)
        collectionView = CSChannelCollectionView(frame: CGRectMake(0, containerScrollView.top + containerScrollView.contentInset.top - collectionViewHeight, containerScrollView.width, collectionViewHeight),collectionViewLayout: flowLayout)
        collectionView.backgroundColor = detailsBackgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(CSChannelCollectionViewCell.self, forCellWithReuseIdentifier: "channelCell")
        collectionView.registerClass(CSHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerReusableView")
        
        navTabBar = CSNavTabBar(frame: CGRectMake(0, containerScrollView.top + containerScrollView.contentInset.top - navTabBarHeight, self.view.width, navTabBarHeight))
        navTabBar.delegate = self
        
        editBar = CSEditBar(frame: CGRectMake(0, 0, navTabBar.width - 40, navTabBar.height))
        editBar.hidden = true
        editBar.delegate = self
        
        self.view.addSubview(containerScrollView)
        self.view.addSubview(collectionView)
        self.view.addSubview(navTabBar)
        navTabBar.addSubview(editBar)
    }
    
    //重新配置UI
    private func refitUI() {
        
        containerScrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height)
        containerScrollView.contentInset = UIEdgeInsetsMake(containerScrollView.contentInset.top, containerScrollView.contentInset.left, 0, containerScrollView.contentInset.right)
        containerScrollView.contentSize = CGSizeMake(containerScrollView.width * CGFloat(viewControllers.count), containerScrollView.height - containerScrollView.contentInset.top)
        containerScrollView.contentOffset = CGPointMake(containerScrollView.width * CGFloat(navTabBar.selectedIndex), containerScrollView.contentOffset.y)
        
        let isIdentity = CGAffineTransformIsIdentity(collectionView.transform)
        collectionView.transform = CGAffineTransformIdentity
        let collectionViewHeight = containerScrollView.contentSize.height
        collectionView.size = CGSizeMake(navTabBar.width, collectionViewHeight)
        collectionView.top = containerScrollView.top + containerScrollView.contentInset.top - collectionViewHeight
        if isIdentity == false {
            collectionView.transform = CGAffineTransformMakeTranslation(0, self.navTabBar.bottom - self.collectionView.top)
        }
        
        navTabBar.frame = CGRectMake(0, containerScrollView.top + containerScrollView.contentInset.top - navTabBarHeight, self.view.width, navTabBarHeight)
        navTabBar.refitUI()
        
        editBar.frame = CGRectMake(0, 0, navTabBar.width - 40, navTabBar.height)
        
        navTabBar.resetOffsetWithAnimation(false)
        for i in 0..<viewControllers.count {
            let vc = viewControllers[i]
            if vc.isViewLoaded() == true {
                vc.view.frame = CGRectMake(CGFloat(i) * containerScrollView.width , 0, containerScrollView.width, containerScrollView.contentSize.height)
            }
        }
    }
    
    //设置collectionView显示或隐藏
    private func setCollectionViewHidden(hidden: Bool) {
        if hidden {
            self.editBar.alpha = 1
            UIView.animateWithDuration(self.animationDuration, animations: { () -> Void in
                self.editBar.alpha = 0
                self.collectionView.transform = CGAffineTransformIdentity
                }, completion: { (finished) -> Void in
                    self.channelEditing = false
                    self.editBar.editButton.selected = false
                    self.editBar.hidden = true
            })
        } else {
            self.editBar.hidden = false
            self.editBar.alpha = 0
            UIView.animateWithDuration(self.animationDuration, animations: { () -> Void in
                self.editBar.alpha = 1
                self.collectionView.transform = CGAffineTransformMakeTranslation(0, self.navTabBar.bottom - self.collectionView.top)
            })
        }
    }
    
    //选中某个vc
    private func selectViewControllerAtIndex(index: Int) {
        let vc = self.viewControllers[index]
        //若vc已加载，则只设置vc.view.frame，否则还需addSubview、addChildViewController
        if !vc.isViewLoaded() {
            vc.view.frame = CGRectMake(CGFloat(index) * containerScrollView.width , 0, containerScrollView.width, containerScrollView.contentSize.height)
            self.containerScrollView.addSubview(vc.view)
            self.addChildViewController(vc)
        }
        containerScrollView.contentOffset = CGPointMake(containerScrollView.width * CGFloat(index), containerScrollView.contentOffset.y)
    }
    
    //改变viewControllers
    private func changeViewControllers(fromViewControllers: [UIViewController], toViewControllers: [UIViewController]) {
        
        // notice: 若调用vc.view的属性，会导致vc提前执行viewDidLoad
        for i in 0..<fromViewControllers.count {
            let vc = fromViewControllers[i]
            //toViewController不包含vc
            if toViewControllers.contains(vc) == false {
                //若vc已经加载过了，则说明vc.view有superView，vc有parentViewController，则移除vc
                if vc.isViewLoaded() == true {
                    vc.removeFromParentViewController()
                    vc.view.removeFromSuperview()
                }
            }
        }
        
        //现将偏移量置初始位置
        containerScrollView.contentOffset = CGPointMake(0, containerScrollView.contentOffset.y)
        //重新设置contentSize
        containerScrollView.contentSize = CGSizeMake(containerScrollView.width * CGFloat(viewControllers.count), containerScrollView.height - containerScrollView.contentInset.top)
        
        var titles = [String]()
        for i in 0..<toViewControllers.count {
            let vc = toViewControllers[i]
            
            if let title = vc.title {
                titles.append(title)
            } else {
                titles.append("item\(i)")
            }
            
            //若fromControllers包含vc，且vc已加载，则重设vc.view.frame
            if fromViewControllers.contains(vc) {
                if vc.isViewLoaded() {
                    vc.view.frame = CGRectMake(CGFloat(i) * containerScrollView.width , 0, containerScrollView.width, containerScrollView.contentSize.height)
                }
            } else {
                //否则，若vc已加载，则重设vc.view.frame，且addSubview、addChildViewController
                if vc.isViewLoaded() {
                    vc.view.frame = CGRectMake(CGFloat(i) * containerScrollView.width , 0, containerScrollView.width, containerScrollView.contentSize.height)
                    self.containerScrollView.addSubview(vc.view)
                    self.addChildViewController(vc)
                }
            }
        }
        self.navTabBar.titles = titles  //设置navTabBar的titles
    }
    
    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view?.isKindOfClass(UIButton.self) == true {
            return false
        }
        return true
    }
    // MARK: Action
    func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        
        guard self.channelEditing == true else {
            return
        }
        switch(gesture.state) {
        case UIGestureRecognizerState.Began:
            
            if self.isAnimating {
                return
            }
            
            //长按的点是否在cell中，如果不是，则return
            guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                return
            }
            //选中的indexPath若为不可选，则return
            if selectedIndexPath.item < self.disabledCount {
                return
            }
            
            self.selectedCell = collectionView.cellForItemAtIndexPath(selectedIndexPath) as! CSChannelCollectionViewCell
            
            self.movingCell = CSChannelCollectionViewCell(frame: self.selectedCell.frame)
            self.movingCell.text = self.selectedCell.text
            self.movingCell.status = self.selectedCell.status
            self.collectionView.addSubview(self.movingCell)
            
            self.movingCell.backgroundImageView.transform = CGAffineTransformMakeScale(channelScale, channelScale)
            
            self.selectedCell.hidden = true //隐藏原本的cell
            
        case UIGestureRecognizerState.Changed:
            
            if self.isAnimating {
                return
            }
            
            if self.selectedCell == nil {
                return
            }
            
            let point = gesture.locationInView(self.collectionView)
            self.movingCell.center = point
            
            //若移动的到另一个cell，则将选中的cell移到另一个cell的位置
            if let toIndexPath = self.collectionView.indexPathForItemAtPoint(point) {
                
                if toIndexPath.item < self.disabledCount {
                    return
                }
                
                let movingIndexPath = self.collectionView.indexPathForCell(self.selectedCell)!
                
                if toIndexPath != movingIndexPath
                {
                    self.collectionView.moveItemAtIndexPath(movingIndexPath, toIndexPath: toIndexPath)
                    
                    let vc = self.myViewControllers[self.collectionView.selectedIndex]
                    
                    let sourceItem = self.myViewControllers.removeAtIndex(movingIndexPath.item)
                    self.myViewControllers.insert(sourceItem, atIndex: toIndexPath.item)
                    
                    self.collectionView.selectedIndex = self.myViewControllers.indexOf(vc)!
                }
            }
            
        case UIGestureRecognizerState.Ended:
            
            if self.selectedCell != nil {
                self.movingCell.backgroundImageView.transform = CGAffineTransformIdentity
                self.isAnimating = true
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    self.movingCell.frame = self.selectedCell!.frame
                    }, completion: { (finished) -> Void in
                        self.isAnimating = false
                        if finished {
                            self.movingCell.removeFromSuperview()
                            self.movingCell = nil
                            self.selectedCell?.hidden = false
                            self.selectedCell = nil
                        }
                })
            }
            
        default:
            
            if self.selectedCell != nil {
                self.movingCell.backgroundImageView.transform = CGAffineTransformIdentity
                self.isAnimating = true
                UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                    self.movingCell.frame = self.selectedCell!.frame
                    }, completion: { (finished) -> Void in
                        self.isAnimating = false
                        if finished {
                            self.movingCell.removeFromSuperview()
                            self.movingCell = nil
                            self.selectedCell?.hidden = false
                            self.selectedCell = nil
                        }
                })
            }
        }
    }
}

// MARK: extension
extension CSNavTabBarController: CSNavTabBarDelegate {
    
    // MARK: --- CSNavTabBarDelegate
    func navTabBar(navTabBar: CSNavTabBar, didSelectItemAtIndex index: Int) {
        if navTabBar == self.navTabBar {
            containerScrollView.contentOffset = CGPointMake(containerScrollView.width * CGFloat(index), containerScrollView.contentOffset.y)
            selectViewControllerAtIndex(index)
        }
    }
    func navTabBar(navTabBar: CSNavTabBar, didClickArrowButton arrowButton: UIButton) {
        if navTabBar == self.navTabBar {
            if arrowButton.selected {
                self.myViewControllers = self.viewControllers
                self.collectionView.selectedIndex = self.navTabBar.selectedIndex
                self.collectionView.reloadData()
                setCollectionViewHidden(false)
                if self.tabBarController?.tabBar.translucent == true {
                    self.tabBarController?.tabBar.hidden = true
                }
            } else {
                self.viewControllers = self.myViewControllers
                self.navTabBar.selectedIndex = self.collectionView.selectedIndex
                selectViewControllerAtIndex(self.collectionView.selectedIndex)
                setCollectionViewHidden(true)
                if self.tabBarController?.tabBar.translucent == true {
                    self.tabBarController?.tabBar.hidden = false
                }
            }
        }
    }
}

extension CSNavTabBarController: CSEditBarDelegate {
    
    // MARK: --- CSeditBarDelegate
    func editBarDidBeginEditing(editBar: CSEditBar) {
        if editBar == self.editBar {
            self.channelEditing = true
            if self.myViewControllers.count > 1 {
                self.longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(CSNavTabBarController.handleLongPressGesture(_:)))
                self.longPressGesture.delegate = self
                self.longPressGesture.minimumPressDuration = 0.01
                collectionView.addGestureRecognizer(self.longPressGesture)
            }
        }
    }
    
    func editBarDidFinishEditing(editBar: CSEditBar) {
        if editBar == self.editBar {
            self.channelEditing = false
            collectionView.removeGestureRecognizer(self.longPressGesture)
        }
    }
}

extension CSNavTabBarController: UIScrollViewDelegate {
    
    // MARK: --- UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView == self.containerScrollView {

            //当前scrollView的偏移量
            let offSetX = scrollView.contentOffset.x
            //当scrollView未滚出边界才执行内部操作
            if offSetX >= 0 && offSetX <= (scrollView.contentSize.width - scrollView.width) {
                //余数（偏移量%宽度）
                let remainder = offSetX % scrollView.width
                //获取当前偏移量相对scrollView宽的倍数
                let mutiple = offSetX / scrollView.width
                
                if remainder == 0.0 {
                    navTabBar.selectedIndex = Int(mutiple)
                    selectViewControllerAtIndex(navTabBar.selectedIndex)
                } else {
                    let leftIndex = Int(mutiple)
                    let rightIndex = leftIndex + 1
                    let rightScale = remainder / scrollView.width
                    let leftScale = 1.0 - rightScale
                    navTabBar.transitionForLeftIndex(leftIndex, rightIndex: rightIndex, leftScale: leftScale, rightScale: rightScale)
                }
            }
        }
    }
}

extension CSNavTabBarController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: --- UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.channelEditing ? 1 : 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.myViewControllers.count
        } else {
            return self.moreViewControllers.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("channelCell", forIndexPath: indexPath) as! CSChannelCollectionViewCell
        
        let vc: UIViewController
        
        if indexPath.section == 0 {
            if indexPath.item < self.disabledCount {
                if self.channelEditing {
                    cell.status = CSChannelStatus.SimpleEditing
                } else {
                    if indexPath.row == self.collectionView.selectedIndex {
                        cell.status = CSChannelStatus.SimpleHighlight
                    } else {
                        cell.status = CSChannelStatus.SimpleNormal
                    }
                }
            } else {
                if self.myViewControllers.count == 1 {
                    if self.channelEditing {
                        cell.status = CSChannelStatus.SimpleEditing
                    } else {
                        cell.status = CSChannelStatus.SimpleHighlight
                    }
                } else {
                    if self.channelEditing {
                        cell.status = CSChannelStatus.Editing
                    } else {
                        if indexPath.row == self.collectionView.selectedIndex {
                            cell.status = CSChannelStatus.Highlight
                        } else {
                            cell.status = CSChannelStatus.Normal
                        }
                    }
                }
            }
            vc = self.myViewControllers[indexPath.item]
        } else {
            cell.status = CSChannelStatus.Normal
            vc = self.moreViewControllers[indexPath.item]
        }
        
        if let title = vc.title {
            cell.text = title
        } else {
            cell.text = "item\(indexPath.item)"
        }
        
        //添加删除按钮点击事件的回调闭包
        cell.deleteActionCallBack { (channelCell) -> Void in
            let index = self.collectionView.indexPathForCell(channelCell)!.item
            if index == self.collectionView.selectedIndex {
                self.collectionView.selectedIndex = 0
            }
            let vc = self.myViewControllers[index]
            self.myViewControllers.removeAtIndex(index)
            self.moreViewControllers.insert(vc, atIndex: 0)
            self.collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: index, inSection: 0)])
            
            if self.myViewControllers.count <= 1 {
                self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
                self.collectionView.removeGestureRecognizer(self.longPressGesture)
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerReusableView", forIndexPath: indexPath) as! CSHeaderReusableView
        reusableView.backgroundColor = headerBackgroundColor
        reusableView.text = "点击添加更多栏目"
        return reusableView
    }
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: --- UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if self.channelEditing == false {
                self.viewControllers = self.myViewControllers
                self.collectionView.selectedIndex = indexPath.item
                self.navTabBar.resetArrowButton()
            }
        } else {
            let vc = self.moreViewControllers[indexPath.item]
            self.moreViewControllers.removeAtIndex(indexPath.item)
            self.myViewControllers.append(vc)
            let toIndexPath = NSIndexPath(forItem: self.myViewControllers.count - 1, inSection: 0)
            collectionView.moveItemAtIndexPath(indexPath, toIndexPath: toIndexPath)
            if self.myViewControllers.count == 2 {
                self.collectionView.reloadItemsAtIndexPaths([NSIndexPath(forItem: 0, inSection: 0)])
            }
        }
    }
    
    // MARK: --- UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSizeMake(0, 30)
        } else {
            return CGSizeZero
        }
    }
}
