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
             // Do any additional setup after loading the view.\
        
        
       print(2)
        
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
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let  string =  NSUserDefaults.standardUserDefaults().valueForKey("photos") as! String
        let array = HelperManager.convertStringToAnyObject(string) as! NSMutableArray
        let decodedData = NSData(base64EncodedString:array.objectAtIndex(indexPath.row) as! String, options:NSDataBase64DecodingOptions())
        let decodedimage = UIImage(data: decodedData!)! as UIImage
        return CGSize(width: decodedimage.size.width/2, height:100)   
    }
    @IBAction func numberPhotosAction(sender: UIButton)
    {
        self.delegate.popViewControllerPhotosArray(self.imageArray)
       //  NSUserDefaults.standardUserDefaults().removeObjectForKey("photos")
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
