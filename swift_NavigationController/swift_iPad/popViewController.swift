//
//  popViewController.swift
//  swift_iPad
//
//  Created by Zhao.bin on 16/3/29.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

import AssetsLibrary

import Photos

protocol popViewControllerDelegate
{
    func popViewControllerPhotosArray(photosImage : UIImage)
    
}

class popViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    var delegate : popViewControllerDelegate!
    //资源库管理类
    var assetsFetchResults =  PHFetchResult()
    //保存照片集合
    var PHIassets = PHImageManager()
    var asset = PHAsset()
    var options = PHFetchOptions()
    var imageManager  = PHImageManager()
    var imageArray:NSMutableArray?
 
    var isSelect = false
    
    override func viewDidLoad()
    {
        photosCollectionView.registerNib(UINib(nibName: "popCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        //多选属性
         photosCollectionView.allowsMultipleSelection = true
        
        assetsFetchResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        
    }
    static func collectionSeletctNmuber(number:NSInteger)
    {
      print(number)
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return assetsFetchResults.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellID", forIndexPath: indexPath) as? popCollectionViewCell
       
        if cell == nil
        {
            let nibArray : NSArray = NSBundle.mainBundle().loadNibNamed("popCollectionViewCell", owner:self, options:nil)
            cell = nibArray.firstObject as? popCollectionViewCell
            
        }
      
        asset = assetsFetchResults[indexPath.row] as! PHAsset
       
        imageManager.requestImageForAsset(asset, targetSize: CGSize.init(width:60, height:40), contentMode: PHImageContentMode.AspectFill, options: nil) { (resultimage,  info) in
           
            cell?.backgroundImagview.image = resultimage
        }
       
        
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {

         let cell = collectionView.cellForItemAtIndexPath(indexPath) as! popCollectionViewCell
        
          cell.backgroundColor = UIColor.greenColor()
      
        print("didSelect====\(indexPath.row)")
        
        asset = assetsFetchResults[indexPath.row] as! PHAsset
        
        imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.Default, options: nil) { (resultimage,  info) in
            self.delegate.popViewControllerPhotosArray(resultimage!)
        }
//        self.dismissViewControllerAnimated(true, completion: nil)
      
    }

    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        
        return true
    }
    //didDeselectItemAtIndexPath
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! popCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        print("didDeselec====\(indexPath.row)")
    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
