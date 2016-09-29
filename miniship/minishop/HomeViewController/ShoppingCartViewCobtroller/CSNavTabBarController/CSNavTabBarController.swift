

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
    
    fileprivate let navTabBarHeight: CGFloat = 40.0  //bar默认高度
    fileprivate let animationDuration: Double = 0.25   //动画时长
    fileprivate let channelScale: CGFloat = 1.2    //移动时选项放大的倍数
    
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    fileprivate var isAnimating: Bool = false   //记录是否在动画过程
    fileprivate var selectedCell: CSChannelCollectionViewCell!    //选中要移动的cell
    fileprivate var movingCell: CSChannelCollectionViewCell! //正在移动的cell
    
    
    fileprivate var myViewControllers = [UIViewController]()    //我的频道
    
    fileprivate(set) var navTabBar: CSNavTabBar!   //导航tabBar
    fileprivate(set) var containerScrollView: UIScrollView!    //容器scrollView
    fileprivate(set) var editBar: CSEditBar!    //下拉列表时显示的编辑bar
    fileprivate(set) var collectionView: CSChannelCollectionView! //编辑tabBar的下拉列表
    
    
    //是否正在编辑
    fileprivate(set) var channelEditing: Bool = false {
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
    fileprivate func configureUI() {
        
        containerScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height))
        containerScrollView.contentInset = UIEdgeInsetsMake(containerScrollView.contentInset.top + navTabBarHeight, containerScrollView.contentInset.left, 0, containerScrollView.contentInset.right)
        containerScrollView.contentSize = CGSize(width: containerScrollView.width * CGFloat(viewControllers.count), height: containerScrollView.height - containerScrollView.contentInset.top)
        containerScrollView.delegate = self
        containerScrollView.isPagingEnabled = true
        containerScrollView.showsHorizontalScrollIndicator = false

        let collectionViewHeight = containerScrollView.contentSize.height
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 70, height: 30)
        flowLayout.minimumLineSpacing = 17
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset = UIEdgeInsetsMake(17, 13, 17, 13)
        collectionView = CSChannelCollectionView(frame: CGRect(x: 0, y: containerScrollView.top + containerScrollView.contentInset.top - collectionViewHeight, width: containerScrollView.width, height: collectionViewHeight),collectionViewLayout: flowLayout)
        collectionView.backgroundColor = detailsBackgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CSChannelCollectionViewCell.self, forCellWithReuseIdentifier: "channelCell")
        collectionView.register(CSHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerReusableView")
        
        navTabBar = CSNavTabBar(frame: CGRect(x: 0, y: containerScrollView.top + containerScrollView.contentInset.top - navTabBarHeight, width: self.view.width, height: navTabBarHeight))
        navTabBar.delegate = self
        
        editBar = CSEditBar(frame: CGRect(x: 0, y: 0, width: navTabBar.width - 40, height: navTabBar.height))
        editBar.isHidden = true
        editBar.delegate = self
        
        self.view.addSubview(containerScrollView)
        self.view.addSubview(collectionView)
        self.view.addSubview(navTabBar)
        navTabBar.addSubview(editBar)
    }
    
    //重新配置UI
    fileprivate func refitUI() {
        
        containerScrollView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        containerScrollView.contentInset = UIEdgeInsetsMake(containerScrollView.contentInset.top, containerScrollView.contentInset.left, 0, containerScrollView.contentInset.right)
        containerScrollView.contentSize = CGSize(width: containerScrollView.width * CGFloat(viewControllers.count), height: containerScrollView.height - containerScrollView.contentInset.top)
        containerScrollView.contentOffset = CGPoint(x: containerScrollView.width * CGFloat(navTabBar.selectedIndex), y: containerScrollView.contentOffset.y)
        
        let isIdentity = collectionView.transform.isIdentity
        collectionView.transform = CGAffineTransform.identity
        let collectionViewHeight = containerScrollView.contentSize.height
        collectionView.size = CGSize(width: navTabBar.width, height: collectionViewHeight)
        collectionView.top = containerScrollView.top + containerScrollView.contentInset.top - collectionViewHeight
        if isIdentity == false {
            collectionView.transform = CGAffineTransform(translationX: 0, y: self.navTabBar.bottom - self.collectionView.top)
        }
        
        navTabBar.frame = CGRect(x: 0, y: containerScrollView.top + containerScrollView.contentInset.top - navTabBarHeight, width: self.view.width, height: navTabBarHeight)
        navTabBar.refitUI()
        
        editBar.frame = CGRect(x: 0, y: 0, width: navTabBar.width - 40, height: navTabBar.height)
        
        navTabBar.resetOffsetWithAnimation(false)
        for i in 0..<viewControllers.count {
            let vc = viewControllers[i]
            if vc.isViewLoaded == true {
                vc.view.frame = CGRect(x: CGFloat(i) * containerScrollView.width , y: 0, width: containerScrollView.width, height: containerScrollView.contentSize.height)
            }
        }
    }
    
    //设置collectionView显示或隐藏
    fileprivate func setCollectionViewHidden(_ hidden: Bool) {
        if hidden {
            self.editBar.alpha = 1
            UIView.animate(withDuration: self.animationDuration, animations: { () -> Void in
                self.editBar.alpha = 0
                self.collectionView.transform = CGAffineTransform.identity
                }, completion: { (finished) -> Void in
                    self.channelEditing = false
                    self.editBar.editButton.isSelected = false
                    self.editBar.isHidden = true
            })
        } else {
            self.editBar.isHidden = false
            self.editBar.alpha = 0
            UIView.animate(withDuration: self.animationDuration, animations: { () -> Void in
                self.editBar.alpha = 1
                self.collectionView.transform = CGAffineTransform(translationX: 0, y: self.navTabBar.bottom - self.collectionView.top)
            })
        }
    }
    
    //选中某个vc
    fileprivate func selectViewControllerAtIndex(_ index: Int) {
        let vc = self.viewControllers[index]
        //若vc已加载，则只设置vc.view.frame，否则还需addSubview、addChildViewController
        if !vc.isViewLoaded {
            vc.view.frame = CGRect(x: CGFloat(index) * containerScrollView.width , y: 0, width: containerScrollView.width, height: containerScrollView.contentSize.height)
            self.containerScrollView.addSubview(vc.view)
            self.addChildViewController(vc)
        }
        containerScrollView.contentOffset = CGPoint(x: containerScrollView.width * CGFloat(index), y: containerScrollView.contentOffset.y)
    }
    
    //改变viewControllers
    fileprivate func changeViewControllers(_ fromViewControllers: [UIViewController], toViewControllers: [UIViewController]) {
        
        // notice: 若调用vc.view的属性，会导致vc提前执行viewDidLoad
        for i in 0..<fromViewControllers.count {
            let vc = fromViewControllers[i]
            //toViewController不包含vc
            if toViewControllers.contains(vc) == false {
                //若vc已经加载过了，则说明vc.view有superView，vc有parentViewController，则移除vc
                if vc.isViewLoaded == true {
                    vc.removeFromParentViewController()
                    vc.view.removeFromSuperview()
                }
            }
        }
        
        //现将偏移量置初始位置
        containerScrollView.contentOffset = CGPoint(x: 0, y: containerScrollView.contentOffset.y)
        //重新设置contentSize
        containerScrollView.contentSize = CGSize(width: containerScrollView.width * CGFloat(viewControllers.count), height: containerScrollView.height - containerScrollView.contentInset.top)
        
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
                if vc.isViewLoaded {
                    vc.view.frame = CGRect(x: CGFloat(i) * containerScrollView.width , y: 0, width: containerScrollView.width, height: containerScrollView.contentSize.height)
                }
            } else {
                //否则，若vc已加载，则重设vc.view.frame，且addSubview、addChildViewController
                if vc.isViewLoaded {
                    vc.view.frame = CGRect(x: CGFloat(i) * containerScrollView.width , y: 0, width: containerScrollView.width, height: containerScrollView.contentSize.height)
                    self.containerScrollView.addSubview(vc.view)
                    self.addChildViewController(vc)
                }
            }
        }
        self.navTabBar.titles = titles  //设置navTabBar的titles
    }
    
    // MARK: UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isKind(of: UIButton.self) == true {
            return false
        }
        return true
    }
    // MARK: Action
    func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        
        guard self.channelEditing == true else {
            return
        }
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            
            if self.isAnimating {
                return
            }
            
            //长按的点是否在cell中，如果不是，则return
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                return
            }
            //选中的indexPath若为不可选，则return
            if (selectedIndexPath as NSIndexPath).item < self.disabledCount {
                return
            }
            
            self.selectedCell = collectionView.cellForItem(at: selectedIndexPath) as! CSChannelCollectionViewCell
            
            self.movingCell = CSChannelCollectionViewCell(frame: self.selectedCell.frame)
            self.movingCell.text = self.selectedCell.text
            self.movingCell.status = self.selectedCell.status
            self.collectionView.addSubview(self.movingCell)
            
            self.movingCell.backgroundImageView.transform = CGAffineTransform(scaleX: channelScale, y: channelScale)
            
            self.selectedCell.isHidden = true //隐藏原本的cell
            
        case UIGestureRecognizerState.changed:
            
            if self.isAnimating {
                return
            }
            
            if self.selectedCell == nil {
                return
            }
            
            let point = gesture.location(in: self.collectionView)
            self.movingCell.center = point
            
            //若移动的到另一个cell，则将选中的cell移到另一个cell的位置
            if let toIndexPath = self.collectionView.indexPathForItem(at: point) {
                
                if (toIndexPath as NSIndexPath).item < self.disabledCount {
                    return
                }
                
                let movingIndexPath = self.collectionView.indexPath(for: self.selectedCell)!
                
                if toIndexPath != movingIndexPath
                {
                    self.collectionView.moveItem(at: movingIndexPath, to: toIndexPath)
                    
                    let vc = self.myViewControllers[self.collectionView.selectedIndex]
                    
                    let sourceItem = self.myViewControllers.remove(at: (movingIndexPath as NSIndexPath).item)
                    self.myViewControllers.insert(sourceItem, at: (toIndexPath as NSIndexPath).item)
                    
                    self.collectionView.selectedIndex = self.myViewControllers.index(of: vc)!
                }
            }
            
        case UIGestureRecognizerState.ended:
            
            if self.selectedCell != nil {
                self.movingCell.backgroundImageView.transform = CGAffineTransform.identity
                self.isAnimating = true
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    self.movingCell.frame = self.selectedCell!.frame
                    }, completion: { (finished) -> Void in
                        self.isAnimating = false
                        if finished {
                            self.movingCell.removeFromSuperview()
                            self.movingCell = nil
                            self.selectedCell?.isHidden = false
                            self.selectedCell = nil
                        }
                })
            }
            
        default:
            
            if self.selectedCell != nil {
                self.movingCell.backgroundImageView.transform = CGAffineTransform.identity
                self.isAnimating = true
                UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                    self.movingCell.frame = self.selectedCell!.frame
                    }, completion: { (finished) -> Void in
                        self.isAnimating = false
                        if finished {
                            self.movingCell.removeFromSuperview()
                            self.movingCell = nil
                            self.selectedCell?.isHidden = false
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
    func navTabBar(_ navTabBar: CSNavTabBar, didSelectItemAtIndex index: Int) {
        if navTabBar == self.navTabBar {
            containerScrollView.contentOffset = CGPoint(x: containerScrollView.width * CGFloat(index), y: containerScrollView.contentOffset.y)
            selectViewControllerAtIndex(index)
        }
    }
    func navTabBar(_ navTabBar: CSNavTabBar, didClickArrowButton arrowButton: UIButton) {
        if navTabBar == self.navTabBar {
            if arrowButton.isSelected {
                self.myViewControllers = self.viewControllers
                self.collectionView.selectedIndex = self.navTabBar.selectedIndex
                self.collectionView.reloadData()
                setCollectionViewHidden(false)
                if self.tabBarController?.tabBar.isTranslucent == true {
                    self.tabBarController?.tabBar.isHidden = true
                }
            } else {
                self.viewControllers = self.myViewControllers
                self.navTabBar.selectedIndex = self.collectionView.selectedIndex
                selectViewControllerAtIndex(self.collectionView.selectedIndex)
                setCollectionViewHidden(true)
                if self.tabBarController?.tabBar.isTranslucent == true {
                    self.tabBarController?.tabBar.isHidden = false
                }
            }
        }
    }
}

extension CSNavTabBarController: CSEditBarDelegate {
    
    // MARK: --- CSeditBarDelegate
    func editBarDidBeginEditing(_ editBar: CSEditBar) {
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
    
    func editBarDidFinishEditing(_ editBar: CSEditBar) {
        if editBar == self.editBar {
            self.channelEditing = false
            collectionView.removeGestureRecognizer(self.longPressGesture)
        }
    }
}

extension CSNavTabBarController: UIScrollViewDelegate {
    
    // MARK: --- UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.containerScrollView {

            //当前scrollView的偏移量
            let offSetX = scrollView.contentOffset.x
            //当scrollView未滚出边界才执行内部操作
            if offSetX >= 0 && offSetX <= (scrollView.contentSize.width - scrollView.width) {
                //余数（偏移量%宽度）
                let remainder = offSetX.truncatingRemainder(dividingBy: scrollView.width)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.channelEditing ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.myViewControllers.count
        } else {
            return self.moreViewControllers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as! CSChannelCollectionViewCell
        
        let vc: UIViewController
        
        if (indexPath as NSIndexPath).section == 0 {
            if (indexPath as NSIndexPath).item < self.disabledCount {
                if self.channelEditing {
                    cell.status = CSChannelStatus.simpleEditing
                } else {
                    if (indexPath as NSIndexPath).row == self.collectionView.selectedIndex {
                        cell.status = CSChannelStatus.simpleHighlight
                    } else {
                        cell.status = CSChannelStatus.simpleNormal
                    }
                }
            } else {
                if self.myViewControllers.count == 1 {
                    if self.channelEditing {
                        cell.status = CSChannelStatus.simpleEditing
                    } else {
                        cell.status = CSChannelStatus.simpleHighlight
                    }
                } else {
                    if self.channelEditing {
                        cell.status = CSChannelStatus.editing
                    } else {
                        if (indexPath as NSIndexPath).row == self.collectionView.selectedIndex {
                            cell.status = CSChannelStatus.highlight
                        } else {
                            cell.status = CSChannelStatus.normal
                        }
                    }
                }
            }
            vc = self.myViewControllers[(indexPath as NSIndexPath).item]
        } else {
            cell.status = CSChannelStatus.normal
            vc = self.moreViewControllers[(indexPath as NSIndexPath).item]
        }
        
        if let title = vc.title {
            cell.text = title
        } else {
            cell.text = "item\((indexPath as NSIndexPath).item)"
        }
        
        //添加删除按钮点击事件的回调闭包
        cell.deleteActionCallBack { (channelCell) -> Void in
            let index = (self.collectionView.indexPath(for: channelCell)! as NSIndexPath).item
            if index == self.collectionView.selectedIndex {
                self.collectionView.selectedIndex = 0
            }
            let vc = self.myViewControllers[index]
            self.myViewControllers.remove(at: index)
            self.moreViewControllers.insert(vc, at: 0)
            self.collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
            
            if self.myViewControllers.count <= 1 {
                self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
                self.collectionView.removeGestureRecognizer(self.longPressGesture)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerReusableView", for: indexPath) as! CSHeaderReusableView
        reusableView.backgroundColor = headerBackgroundColor
        reusableView.text = "点击添加更多栏目"
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if (indexPath as NSIndexPath).section == 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: --- UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0 {
            if self.channelEditing == false {
                self.viewControllers = self.myViewControllers
                self.collectionView.selectedIndex = (indexPath as NSIndexPath).item
                self.navTabBar.resetArrowButton()
            }
        } else {
            let vc = self.moreViewControllers[(indexPath as NSIndexPath).item]
            self.moreViewControllers.remove(at: (indexPath as NSIndexPath).item)
            self.myViewControllers.append(vc)
            let toIndexPath = IndexPath(item: self.myViewControllers.count - 1, section: 0)
            collectionView.moveItem(at: indexPath, to: toIndexPath)
            if self.myViewControllers.count == 2 {
                self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
            }
        }
    }
    
    // MARK: --- UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: 0, height: 30)
        } else {
            return CGSize.zero
        }
    }
}
