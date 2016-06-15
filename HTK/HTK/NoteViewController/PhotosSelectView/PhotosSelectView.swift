//
//  PhotosSelectView.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

import Photos

class PhotosSelectView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,popViewControllerDelegate
{
    
    @IBOutlet weak var photosCollection: UICollectionView!
    @IBOutlet var _photosSelectView: PhotosSelectView!
    var photosSelectView = UIViewController()
    var photosImageArray = NSMutableArray()
    
    //资源库管理类
    var assetsFetchResults =  PHFetchResult()
    //保存照片集合
    var PHIassets = PHImageManager()
    var asset = PHAsset()
    var options = PHFetchOptions()
    var imageManager  = PHImageManager()
    var imageArray = NSMutableArray()
    var selectedArray = NSMutableArray()
    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("PhotosSelectView", owner:self,options:nil)
         photosCollection.registerNib(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        self.addSubview(_photosSelectView)
        photosUserDefaults()

    }
  //MARK: 照片缓存
    func photosUserDefaults()
    {
        assetsFetchResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        for index in 1...assetsFetchResults.count
        {
            asset = assetsFetchResults[index - 1] as! PHAsset
            
            imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFit, options: nil) { (resultimage,  info) in
                
                let imageData = UIImagePNGRepresentation(resultimage!)
                let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
                
                self.selectedArray.addObject(base64String)
                let data : NSData! = try? NSJSONSerialization.dataWithJSONObject(self.selectedArray, options: [])
                //NSData转换成NSString打印输出
                let str = NSString(data:data, encoding: NSUTF8StringEncoding)
                
                NSUserDefaults.standardUserDefaults().setObject(str, forKey: "photos")
            }
            
        }
    
    
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
