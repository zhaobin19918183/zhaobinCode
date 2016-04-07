//
//  CSPopNewsViewController.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        print("third viewDidLoad")

        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectMake(0, 0, self.view.width, self.view.height), collectionViewLayout: flowLayout)
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        /*若tabbar为透明的，需要将collectionView的contentInset的bottom设为tabBar的高度
        才能避免底部被tabBar挡住*/
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)

    }

    override func viewWillLayoutSubviews() {
        collectionView.frame = CGRectMake(0, 0, self.view.width, self.view.height)
    }

}

extension ThirdViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        switch indexPath.item % 4 {
        case 0:
            cell.contentView.backgroundColor = UIColor.redColor()
        case 1:
            cell.contentView.backgroundColor = UIColor.greenColor()
        case 2:
            cell.contentView.backgroundColor = UIColor.blueColor()
        case 3:
            cell.contentView.backgroundColor = UIColor.orangeColor()
        case 4:
            cell.contentView.backgroundColor = UIColor.purpleColor()
        default:
            cell.contentView.backgroundColor = UIColor.yellowColor()
        }
        
        return cell
    }
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com