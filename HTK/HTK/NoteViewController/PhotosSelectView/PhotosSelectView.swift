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
    var photosImageArray = NSMutableArray()
    
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
 
        self.photosImageArray = photosImageArray
        self.photosCollection.reloadData()
        
    }
    //MARK:CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.photosImageArray.count == 0 {
            return 1
        }
        
        return  self.photosImageArray.count + 1
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
        if self.photosImageArray.count != 0 && indexPath.row < self.photosImageArray.count{
            
           cell?.backgroundImageView.image = self.photosImageArray.objectAtIndex(indexPath.row ) as? UIImage
           // print(indexPath.row)
            cell?.delectButton.hidden = false
            cell?.delectButton.tag = indexPath.row
            cell?.delectButton.addTarget(self, action: #selector(PhotosSelectView.deleteImage(_:)), forControlEvents: UIControlEvents.TouchDown)
        }
        else
        {
            
         cell?.backgroundImageView.image = UIImage(named:"jiahao")
         cell?.delectButton.hidden = true
        
        }
        return cell!
        
    }
    func deleteImage(button:UIButton)
    {
        print(button.tag)
        self.photosImageArray.removeObject(self.photosImageArray[button.tag])
        self.photosCollection.reloadData()
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == self.photosImageArray.count
        {
            
            let loginView = PhotosSelectManager()
            loginView.delegate = self
            loginView.view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha:0)
            loginView.imageArray = self.photosImageArray
            photosSelectView.presentViewController(loginView, animated: true, completion: nil)
        }
        
    }
    


}
