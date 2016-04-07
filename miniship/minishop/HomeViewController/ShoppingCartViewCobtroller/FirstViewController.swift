//
//  FirstViewController.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("first viewDidLoad")
//
//        tableView = UITableView(frame: CGRectMake(0, 0, self.view.width, self.view.height), style: UITableViewStyle.Plain)
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        self.view.addSubview(tableView)
//        
//        let tableHeaderView = UIView(frame: CGRectMake(0, 0, tableView.width, 280))
//        let imageView = UIImageView(frame: CGRectMake(0, 0, tableView.width, 150))
//        imageView.image = UIImage(named: "newsPicture.jpg")
//        
//        let label = UILabel(frame: CGRectMake(0, imageView.bottom, imageView.width, 130))
//        label.backgroundColor = UIColor.greenColor()
//        label.numberOfLines = 0
//        label.font = UIFont.systemFontOfSize(12.0)
//        label.text = "升级版-较简单版多了许多功能，升级版花了许多时间，头都大了，干脆把夜间效果去掉\n升级版继承CSNavTabBarController，并设置viewControllers、moreViewControllers即可使用，设置disabledCount可固定不可编辑的个数\n可以重写tabBar代理方法中，在箭头取消选中时对我的栏目、更多栏目进行本地化保存\n只有第一次选中某个childViewController才会执行viewDidLoad\n作者：huangchusheng（转载请注明来源）"
        
//        tableHeaderView.addSubview(imageView)
//        tableHeaderView.addSubview(label)
        
      //  tableView.tableHeaderView = tableHeaderView
        
        /*若tabbar为透明的，需要将tableView的contentInset的bottom设为tabBar的高度
        才能避免底部被tabBar挡住*/
        //tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
    }
    override func viewWillLayoutSubviews() {
       // tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height)
        
    }
    override func viewWillAppear(animated: Bool) {
        print("first viewWillAppear")
    }
    override func viewDidAppear(animated: Bool) {
        print("first viewDidAppear")
    }
    override func viewWillDisappear(animated: Bool) {
        print("first viewWillDisappear")
    }
    override func viewDidDisappear(animated: Bool) {
        print("first viewDidDisappear")
    }
    override func didMoveToParentViewController(parent: UIViewController?) {
        print("first didMoveToParentViewController")
    }
    
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        cell.textLabel?.text = "第\(indexPath.row)行"
        
        return cell
    }
}




// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com