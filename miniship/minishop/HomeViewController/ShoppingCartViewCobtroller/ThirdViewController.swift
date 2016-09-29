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
        self.view.backgroundColor = UIColor.yellow
        print("third viewDidLoad")

        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height), collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        /*若tabbar为透明的，需要将collectionView的contentInset的bottom设为tabBar的高度
        才能避免底部被tabBar挡住*/
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)

    }

    override func viewWillLayoutSubviews() {
        collectionView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
    }

}

extension ThirdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch (indexPath as NSIndexPath).item % 4 {
        case 0:
            cell.contentView.backgroundColor = UIColor.red
        case 1:
            cell.contentView.backgroundColor = UIColor.green
        case 2:
            cell.contentView.backgroundColor = UIColor.blue
        case 3:
            cell.contentView.backgroundColor = UIColor.orange
        case 4:
            cell.contentView.backgroundColor = UIColor.purple
        default:
            cell.contentView.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
}
