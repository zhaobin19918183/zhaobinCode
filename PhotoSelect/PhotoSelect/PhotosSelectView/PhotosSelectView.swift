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
    var didselectImageArray = NSMutableArray()
    //资源库管理类
    var assetsFetchResults =  PHFetchResult<AnyObject>()
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
        
        Bundle.main.loadNibNamed("PhotosSelectView", owner:self,options:nil)
        photosCollection.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellID")
        self.addSubview(_photosSelectView)
        
    }
    //MARK: 照片缓存
    func photosUserDefaults()
    {
        assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil) as! PHFetchResult<AnyObject>
        if assetsFetchResults.count != 0
        {
            for index in 1...assetsFetchResults.count
            {
                asset = assetsFetchResults[index - 1] as! PHAsset
                
                imageManager.requestImage(for: asset, targetSize:PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFit, options: nil) { (resultimage,  info) in
                    
                    let imageData = UIImagePNGRepresentation(resultimage!)
                    let base64String = imageData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
                    
                    self.selectedArray.add(base64String)
                    let data : Data! = try? JSONSerialization.data(withJSONObject: self.selectedArray, options: [])
                    //NSData转换成NSString打印输出
                    let str = NSString(data:data, encoding: String.Encoding.utf8.rawValue)
                    UserDefaults.standard.set(str, forKey: "photos")
                }
                
            }
            
        }
    }
    
    func popViewControllerPhotosArray(_ photosImageArray : NSMutableArray)
    {
        
        self.photosImageArray = photosImageArray
        self.photosCollection.reloadData()
        
    }
    //MARK:CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.photosImageArray.count == 0 {
            return 1
        }
        
        return  self.photosImageArray.count + 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellID", for: indexPath) as? PhotosCollectionViewCell
        if cell == nil
        {
            let nibArray:NSArray = Bundle.main.loadNibNamed("PhotosCollectionViewCell", owner:self, options:nil)! as NSArray
            cell = nibArray.firstObject as? PhotosCollectionViewCell
        }
        if self.photosImageArray.count != 0 && (indexPath as NSIndexPath).row < self.photosImageArray.count{
            
            cell?.backgroundImageView.image = self.photosImageArray.object(at: (indexPath as NSIndexPath).row ) as? UIImage
            // print(indexPath.row)
            cell?.delectButton.isHidden = false
            cell?.delectButton.tag = (indexPath as NSIndexPath).row
            cell?.delectButton.addTarget(self, action:
                #selector(PhotosSelectView.deleteImage(_:)), for: UIControlEvents.touchDown)
        }
        else
        {
            
            cell?.backgroundImageView.image = UIImage(named:"jiahao")
            cell?.delectButton.isHidden = true
            
        }
        return cell!
        
    }
    func deleteImage(_ button:UIButton)
    {
        print(button.tag)
        self.photosImageArray.remove(self.photosImageArray[button.tag])
        self.photosCollection.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if (indexPath as NSIndexPath).row == self.photosImageArray.count
        {
            
            let loginView = PhotosSelectManager()
            loginView.delegate = self
            loginView.view.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha:0)
            loginView.imageArray = self.photosImageArray
            photosSelectView.present(loginView, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    
}
