//
//  BusTableViewController.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/3.
//  Copyright © 2016年 赵斌. All rights reserved.
//



import UIKit

import Alamofire

class emailMenuItem: UIMenuItem{
    var indexPath: NSIndexPath!
}

class BusTableViewController: UITableViewController,SectionHeaderViewDelegate{
    
    let SectionHeaderViewIdentifier = "SectionHeaderViewIdentifier"
    var plays:NSArray!
    var sectionInfoArray:NSMutableArray!
    var pinchedIndexPath:NSIndexPath!
    var opensectionindex:Int!
    var initialPinchHeight:CGFloat!
    
    var playe:NSMutableArray?
    
    var sectionHeaderView:SectionHeaderView!
    
    //当缩放手势同时改变了所有单元格高度时使用uniformRowHeight
    var uniformRowHeight: Int!
    
    let DefaultRowHeight = 88
    let HeaderHeight = 48
    //MARK: 开始
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        let nextItem=UIBarButtonItem(title:"Home",style:.Plain,target:self,action:#selector(backHomeView))
        self.navigationItem.leftBarButtonItem = nextItem
        // 为表视图添加缩放手势识别
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action:#selector(BusTableViewController.handlePinch(_:)))
        self.tableView.addGestureRecognizer(pinchRecognizer)
        self.tableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        // 设置Header的高度
        self.tableView.sectionHeaderHeight = CGFloat(HeaderHeight)
        
        // 分节信息数组在viewWillUnload方法中将被销毁，因此在这里设置Header的默认高度是可行的。如果您想要保留分节信息等内容，可以在指定初始化器当中设置初始值。
        
        self.uniformRowHeight = DefaultRowHeight
        self.opensectionindex = NSNotFound
        
        let sectionHeaderNib: UINib = UINib(nibName: "SectionHeaderView", bundle: nil)
        
        self.tableView.registerNib(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: SectionHeaderViewIdentifier)
        
        plays = played()
    }
    func backHomeView()
    {
        
        self.navigationController!.popViewControllerAnimated(true)
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    //MARK:viewWillAppear
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 检查分节信息数组是否已被创建，如果其已创建，则再检查节的数量是否仍然匹配当前节的数量。通常情况下，您需要保持分节信息与单元格、分节格同步u过您要允许在表视图中编辑信息，您需要在编辑操作中适当更新分节信息。
        
        if self.sectionInfoArray == nil || self.sectionInfoArray.count != self.numberOfSectionsInTableView(self.tableView) {
            
            //对于每个场次来说，需要为每个单元格设立一个一致的、包含默认高度的SectionInfo对象。
            let infoArray = NSMutableArray()
            
            for play in self.plays {
                _ = (play as! Play).quotations
                let sectionInfo = SectionInfo()
                sectionInfo.play = play as! Play
                sectionInfo.open = false
                
                let defaultRowHeight = DefaultRowHeight
                let countOfQuotations = sectionInfo.play.quotations.count
                for i in 0...countOfQuotations {
                    sectionInfo.insertObject(defaultRowHeight, inRowHeightsAtIndex: i)
                }
                
                
                infoArray.addObject(sectionInfo)
            }
            
            self.sectionInfoArray  = infoArray
        }
    }
    //MARK:分组数量
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 这个方法返回 tableview 有多少个section
        return self.plays.count
    }
    // MARK: 单元格数量
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 这个方法返回对应的section有多少个元素，也就是多少行
        let sectionInfo: SectionInfo = self.sectionInfoArray[section] as! SectionInfo
        let numStoriesInSection = sectionInfo.play.quotations.count
        let sectionOpen = sectionInfo.open!
        
        return sectionOpen ? numStoriesInSection : 0
    }
    //MARK: 单元格样式
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 返回指定的row 的cell。这个地方是比较关键的地方，一般在这个地方来定制各种个性化的 cell元素。这里只是使用最简单最基本的cell 类型。其中有一个主标题 cell.textLabel 还有一个副标题cell.detailTextLabel,  还有一个 image在最前头 叫cell.imageView.  还可以设置右边的图标，通过cell.accessoryType 可以设置是饱满的向右的蓝色箭头，还是单薄的向右箭头，还是勾勾标记。
        
        let QuoteCellIdentifier = "QuoteCellIdentifier"
        let cell: QuoteCell = tableView.dequeueReusableCellWithIdentifier(QuoteCellIdentifier) as! QuoteCell
        
        if cell.longPressRecognizer == nil {
            let longPressRecognizer: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(BusTableViewController.handleLongPress(_:)))
            cell.longPressRecognizer = longPressRecognizer
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let play:Play = (self.sectionInfoArray[indexPath.section] as! SectionInfo).play
        cell.quotation = play.quotations[indexPath.row] as! Quotation
        
        cell.setTheQuotation(cell.quotation)
        cell.setTheLongPressRecognizer(cell.longPressRecognizer)
        return cell
    }
    //MARK:Header View
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 返回指定的 section header 的view，如果没有，这个函数可以不返回view
        let sectionHeaderView: SectionHeaderView = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier(SectionHeaderViewIdentifier) as! SectionHeaderView
        let sectionInfo: SectionInfo = self.sectionInfoArray[section] as! SectionInfo
        sectionInfo.headerView = sectionHeaderView
        
        sectionHeaderView.titleLabel.text = sectionInfo.play.name
        sectionHeaderView.section = section
        sectionHeaderView.delegate = self
        
        return sectionHeaderView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 这个方法返回指定的 row 的高度
        let sectionInfo: SectionInfo = self.sectionInfoArray[indexPath.section] as! SectionInfo
        
        return CGFloat(sectionInfo.objectInRowHeightsAtIndex(indexPath.row) as! NSNumber)
        //又或者，返回单元格的行高
    }
    
    // _________________________________________________________________________
    // SectionHeaderViewDelegate
    
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionOpened: Int) {
        
        let sectionInfo: SectionInfo = self.sectionInfoArray[sectionOpened] as! SectionInfo
        
        sectionInfo.open = true
        
        //创建一个包含单元格索引路径的数组来实现插入单元格的操作：这些路径对应当前节的每个单元格
        
        let countOfRowsToInsert = sectionInfo.play.quotations.count
        let indexPathsToInsert = NSMutableArray()
        
        for i in 0 ..< countOfRowsToInsert {
            indexPathsToInsert.addObject(NSIndexPath(forRow: i, inSection: sectionOpened))
        }
        
        // 创建一个包含单元格索引路径的数组来实现删除单元格的操作：这些路径对应之前打开的节的单元格
        
        let indexPathsToDelete = NSMutableArray()
        
        let previousOpenSectionIndex = self.opensectionindex
        if previousOpenSectionIndex != NSNotFound {
            
            let previousOpenSection: SectionInfo = self.sectionInfoArray[previousOpenSectionIndex] as! SectionInfo
            previousOpenSection.open = false
            previousOpenSection.headerView.toggleOpenWithUserAction(false)
            let countOfRowsToDelete = previousOpenSection.play.quotations.count
            for i in 0 ..< countOfRowsToDelete {
                indexPathsToDelete.addObject(NSIndexPath(forRow: i, inSection: previousOpenSectionIndex))
            }
        }
        
        // 设计动画，以便让表格的打开和关闭拥有一个流畅（很屌）的效果
        var insertAnimation: UITableViewRowAnimation
        var deleteAnimation: UITableViewRowAnimation
        if previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex {
            insertAnimation = UITableViewRowAnimation.Top
            deleteAnimation = UITableViewRowAnimation.Bottom
        }else{
            insertAnimation = UITableViewRowAnimation.Bottom
            deleteAnimation = UITableViewRowAnimation.Top
        }
        
        // 应用单元格的更新
        self.tableView.beginUpdates()
        self.tableView.deleteRowsAtIndexPaths(indexPathsToDelete as [AnyObject] as! [NSIndexPath] , withRowAnimation: deleteAnimation)
        self.tableView.insertRowsAtIndexPaths(indexPathsToInsert as [AnyObject] as! [NSIndexPath], withRowAnimation: insertAnimation)
        
        self.opensectionindex = sectionOpened
        
        self.tableView.endUpdates()
    }
    
    func sectionHeaderView(sectionHeaderView: SectionHeaderView, sectionClosed: Int) {
        
        // 在表格关闭的时候，创建一个包含单元格索引路径的数组，接下来从表格中删除这些行
        let sectionInfo: SectionInfo = self.sectionInfoArray[sectionClosed] as! SectionInfo
        
        sectionInfo.open = false
        let countOfRowsToDelete = self.tableView.numberOfRowsInSection(sectionClosed)
        
        if countOfRowsToDelete > 0 {
            let indexPathsToDelete = NSMutableArray()
            for i in 0 ..< countOfRowsToDelete {
                indexPathsToDelete.addObject(NSIndexPath(forRow: i, inSection: sectionClosed))
            }
            self.tableView.deleteRowsAtIndexPaths(indexPathsToDelete as [AnyObject] as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
        }
        self.opensectionindex = NSNotFound
    }
    
    // ____________________________________________________________________
    //MARK: 缩放操作处理
    
    func handlePinch(pinchRecognizer: UIPinchGestureRecognizer) {
        
        // 有手势识别有很多状态来对应不同的动作：
        // * 对于 Began 状态来说，是用缩放点的位置来找寻单元格的索引路径，并将索引路径与缩放操作进行绑定，同时在 pinchedIndexPath 中保留一个引用。接下来方法获取单元格的高度，然后存储其在缩放开始前的高度。最后，为缩放的单元格更新比例。
        // * 对于 Changed 状态来说，是为缩放的单元格更新比例（由 pinchedIndexPath 支持）
        // * 对于 Ended 或者 Canceled状态来说，是将 pinchedIndexPath 属性设置为 nil
        
        NSLog("pinch Gesture")
        if pinchRecognizer.state == UIGestureRecognizerState.Began {
            
            let pinchLocation = pinchRecognizer.locationInView(self.tableView)
            let newPinchedIndexPath = self.tableView.indexPathForRowAtPoint(pinchLocation)
            self.pinchedIndexPath = newPinchedIndexPath
            
            let sectionInfo: SectionInfo = self.sectionInfoArray[newPinchedIndexPath!.section] as! SectionInfo
            self.initialPinchHeight = sectionInfo.objectInRowHeightsAtIndex(newPinchedIndexPath!.row) as! CGFloat
            NSLog("pinch Gesture began")
            // 也可以设置为 initialPinchHeight = uniformRowHeight
            
            self.updateForPinchScale(pinchRecognizer.scale, indexPath: newPinchedIndexPath!)
        }else {
            if pinchRecognizer.state == UIGestureRecognizerState.Changed {
                self.updateForPinchScale(pinchRecognizer.scale, indexPath: self.pinchedIndexPath)
            }else if pinchRecognizer.state == UIGestureRecognizerState.Cancelled || pinchRecognizer.state == UIGestureRecognizerState.Ended {
                self.pinchedIndexPath = nil
            }
        }
    }
    
    func updateForPinchScale(scale: CGFloat, indexPath:NSIndexPath?) {
        
        let section:NSInteger = indexPath!.section
        let row:NSInteger = indexPath!.row
        let found:NSInteger = NSNotFound
        if  (section != found) && (row != found) && indexPath != nil {
            
            var newHeight:CGFloat!
            if self.initialPinchHeight > CGFloat(DefaultRowHeight) {
                newHeight = round(self.initialPinchHeight)
            }else {
                newHeight = round(CGFloat(DefaultRowHeight))
            }
            
            let sectionInfo: SectionInfo = self.sectionInfoArray[indexPath!.section] as! SectionInfo
            sectionInfo.replaceObjectInRowHeightsAtIndex(indexPath!.row, withObject: (newHeight))
            // 也可以设置为 uniformRowHeight = newHeight
            
            // 在单元格高度改变时关闭动画， 不然的话就会有迟滞的现象
            
            let animationsEnabled: Bool = UIView.areAnimationsEnabled()
            UIView.setAnimationsEnabled(false)
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            UIView.setAnimationsEnabled(animationsEnabled)
        }
    }
    
    // ________________________________________________________________________
    //MARK: 处理长按手势
    
    func handleLongPress(longPressRecognizer: UILongPressGestureRecognizer) {
        
        // 对于长按手势来说，唯一的状态是Began
        // 当长按手势被识别后，将会找寻按压点的单元格的索引路径
        // 如果按压位置存在一个单元格，那么就会创建一个菜单并展示它
        
        if longPressRecognizer.state == UIGestureRecognizerState.Began {
            
            let pressedIndexPath = self.tableView.indexPathForRowAtPoint(longPressRecognizer.locationInView(self.tableView))
            
            if pressedIndexPath != nil && pressedIndexPath?.row != NSNotFound && pressedIndexPath?.section != NSNotFound {
                
                self.becomeFirstResponder()
                let title = NSBundle.mainBundle().localizedStringForKey("邮件", value: "", table: nil)
                let menuItem: emailMenuItem = emailMenuItem(title: title, action: #selector(BusTableViewController.emailMenuButtonPressed(_:)))
                menuItem.indexPath = pressedIndexPath
                
                let menuController = UIMenuController.sharedMenuController()
                menuController.menuItems = [menuItem]
                
                var cellRect = self.tableView.rectForRowAtIndexPath(pressedIndexPath!)
                // 略微减少对象的长宽高（不要让其在单元格上方显示得太高）
                cellRect.origin.y = cellRect.origin.y + 40.0
                menuController.setTargetRect(cellRect, inView: self.tableView)
                menuController.setMenuVisible(true, animated: true)
            }
        }
    }
    
    func emailMenuButtonPressed(menuController: UIMenuController) {
        
        let menuItem: emailMenuItem = UIMenuController.sharedMenuController().menuItems![0] as! emailMenuItem
        if menuItem.indexPath != nil {
            self.resignFirstResponder()
            self.sendEmailForEntryAtIndexPath(menuItem.indexPath)
        }
    }
    
    func sendEmailForEntryAtIndexPath(indexPath: NSIndexPath) {
        
        let play: Play = self.plays[indexPath.section] as! Play
        let quotation: Quotation = play.quotations[indexPath.row] as! Quotation
        
        // 在实际使用中，可以调用邮件的API来实现真正的发送邮件
        print("用以下语录发送邮件: \(quotation.quotation)")
    }
    
    
    
    func played() -> NSArray {
        
        if playe == nil {
            
//            let filePath = NSBundle.mainBundle().pathForResource("dataList.plist", ofType:nil )
//            let listData = NSArray(contentsOfFile: filePath!)!
            
            let playDict = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/busCar.plist")
            
            let playName = playDict!.objectAtIndex(0) as! NSMutableArray
            
            playe = NSMutableArray(capacity: playName.count)
            
            for playDictionary in playName {
                let play: Play! = Play()
                play.name = playDictionary.valueForKey("name") as! String
                
                let quotationDictionaries:NSArray = playDictionary["stationdes"] as! NSArray
                
                let quotations = NSMutableArray(capacity: quotationDictionaries.count)
                
                for quotationDictionary in quotationDictionaries {
                    
                    let quotationDic:NSDictionary = quotationDictionary as! NSDictionary
                    let quotation: Quotation = Quotation()
                    
                    quotation.setValuesForKeysWithDictionary(quotationDic as! [String : AnyObject])
                    quotations.addObject(quotation)
                }
                play.quotations = quotations
                playe!.addObject(play)
            }
        }
        
        return playe!
    }
}





