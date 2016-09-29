//
//  SecondViewController.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("second viewDidLoad")

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        /*若tabbar为透明的，需要将tableView的contentInset的bottom设为tabBar的高度
        才能避免底部被tabBar挡住*/
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("second viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("second viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("second viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("second viewDidDisappear")
    }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "第\((indexPath as NSIndexPath).section)分区 - 第\((indexPath as NSIndexPath).row)行"
        return cell
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
