//
//  PhotosSelectView.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

class PhotosSelectView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,popViewControllerDelegate
{
    
    @IBOutlet weak var photosCollection: UICollectionView!
    @IBOutlet var _photosSelectView: PhotosSelectView!
    var photosSelectView = UIViewController()
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    
    func  resetUILayout()
    {
        
        
        NSBundle.mainBundle().loadNibNamed("PhotosSelectView", owner:self,options:nil)
         photosCollection.registerNib(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        self.addSubview(_photosSelectView)
        
        
        
    }
    func popViewControllerPhotosArray(photosImageArray : NSMutableArray)
    {
          print(photosImageArray)
    }
    //MARK:CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellID", forIndexPath: indexPath) as? PhotosCollectionViewCell
        if cell == nil
        {
            let nibArray : NSArray = NSBundle.mainBundle().loadNibNamed("PhotosCollectionViewCell", owner:self, options:nil)
            cell = nibArray.firstObject as? PhotosCollectionViewCell
        }
       
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let loginView = PhotosSelectManager()
        loginView.delegate = self
        loginView.view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha:0)
        
        photosSelectView.presentViewController(loginView, animated: true, completion: nil)
        
    }
    


}
