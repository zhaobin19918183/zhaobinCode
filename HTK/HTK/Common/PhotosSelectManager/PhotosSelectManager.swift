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
    var selectedArray = NSMutableArray()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .Custom
         assetsFetchResults = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
       
      collectionView.registerNib(UINib(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellId")
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCellId", forIndexPath: indexPath) as? PhotosCollectionCell
      
        asset = assetsFetchResults[indexPath.row] as! PHAsset
        
        imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.AspectFit, options: nil) { (resultimage,  info) in
            
           cell?.backgroundImageVIew.image = resultimage
           
        }
        if cell?.selected == true {
           
            cell?.imageLable!.text = "\u{e615}"
        }
        else
        {
            cell?.imageLable!.text = "\u{e614}"
        }
    
        return cell!
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionCell
        cell.imageLable!.font = UIFont(name: "iconfont", size: 20)
        cell.imageLable!.text = "\u{e615}"
        self.imageArray.addObject(cell.backgroundImageVIew.image!)
         print(" did  ===== \(self.imageArray)")

    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionCell
        cell.imageLable!.font = UIFont(name: "iconfont", size: 20)
        cell.imageLable!.text = "\u{e614}"
        self.imageArray.removeObject(cell.backgroundImageVIew.image!)
         print(" dis  ===== \(self.imageArray)")

        
    }
    @IBAction func numberPhotosAction(sender: UIButton)
    {
        self.delegate.popViewControllerPhotosArray(self.imageArray)
        dismiss()
    }
    
    @IBAction func cancleButtonAction(sender: UIButton)
    {
       
            
    }
    func dismiss()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
