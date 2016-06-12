//
//  PhotosSelectManager.swift
//  HTK
//
//  Created by Zhao.bin on 16/6/12.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit

import Photos
protocol popViewControllerDelegate
{
    func popViewControllerPhotosArray(photosImageArray : NSMutableArray)
    
}
class PhotosSelectManager: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberPhotos: UIButton!
    var delegate : popViewControllerDelegate!
    @IBOutlet weak var cancleButton: UIButton!
    
    //资源库管理类
    var assetsFetchResults =  PHFetchResult()
    //保存照片集合
    var PHIassets = PHImageManager()
    var asset = PHAsset()
    var options = PHFetchOptions()
    var imageManager  = PHImageManager()
    var imageArray = NSMutableArray()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .Custom
         assetsFetchResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
       
     collectionView.registerNib(UINib(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
      collectionView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.
    }

    //MARK:CollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return assetsFetchResults.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellID", forIndexPath: indexPath) as? PhotosCollectionCell
        if cell == nil
        {
            let nibArray : NSArray = NSBundle.mainBundle().loadNibNamed("PhotosCollectionCell", owner:self, options:nil)
            cell = nibArray.firstObject as? PhotosCollectionCell
        }
        asset = assetsFetchResults[indexPath.row] as! PHAsset
        
        imageManager.requestImageForAsset(asset, targetSize: CGSize.init(width:60, height:40), contentMode: PHImageContentMode.AspectFit, options: nil) { (resultimage,  info) in
            
            cell?.backgroundImageVIew.image = resultimage
   
        }

        
        return cell!
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionCell
        cell.backgroundColor = UIColor.greenColor()
        
//        print("didSelect====\(indexPath.row)")
        
        asset = assetsFetchResults[indexPath.row] as! PHAsset
        
        imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (resultimage,  info) in
            self.imageArray.addObject(resultimage!)
           
           
           // self.numberPhotos.titleLabel?.text = String(format: "%d",self.imageArray.count)
        }
       
         print(self.imageArray.count+1)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionCell
        cell.backgroundColor = UIColor.grayColor()
        asset = assetsFetchResults[indexPath.row] as! PHAsset
        
        imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFill, options: nil) { (resultimage,  info) in
            print(resultimage)
            let index = self.imageArray.indexOfObject((resultimage?.images!)!)
            print(index)
            //self.imageArray.removeObject(self.imageArray.objectAtIndex(index))
            
            // self.numberPhotos.titleLabel?.text = String(format: "%d",self.imageArray.count)
        }

//        print(self.imageArray)
//        print("didDeselec====\(indexPath.row)")
        
    }
    @IBAction func numberPhotosAction(sender: UIButton)
    {
        
    }
    
    @IBAction func cancleButtonAction(sender: UIButton)
    {
         self.delegate.popViewControllerPhotosArray(self.imageArray)
         dismiss()
    }
    func dismiss()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
