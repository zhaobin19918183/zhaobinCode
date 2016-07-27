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
class PhotosSelectManager: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberPhotos: UIButton!
    var delegate : popViewControllerDelegate!
    
    @IBOutlet weak var photosButton: UIButton!
    
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
        
        //        imageManager.requestImageDataForAsset(asset, options: PHImageRequestOptions.init()) { (data, string, imageOrientation, dic) in
        //           print(data)
        //
        //        }
        imageManager.requestImageForAsset(asset, targetSize:PHImageManagerMaximumSize,contentMode: PHImageContentMode.AspectFit, options: nil) { (resultimage,  info) in
            
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
        self.selectedArray.addObject(cell.backgroundImageVIew.image!)
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotosCollectionCell
        cell.imageLable!.font = UIFont(name: "iconfont", size: 20)
        cell.imageLable!.text = "\u{e614}"
        self.imageArray.removeObject(cell.backgroundImageVIew.image!)
        
    }
    //MARK:取出图片按照图片大小确定cell 的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        //        let  string =  NSUserDefaults.standardUserDefaults().valueForKey("photos") as! String
        //        let array = HelperManager.convertStringToAnyObject(string) as! NSMutableArray
        //
        //        let decodedData = NSData(base64EncodedString:array.objectAtIndex(indexPath.row) as! String, options:NSDataBase64DecodingOptions())
        //        let decodedimage = UIImage(data: decodedData!)! as UIImage
        //        print(decodedimage.size.width)
        return CGSize(width: 120, height:120)
    }
    @IBAction func numberPhotosAction(sender: UIButton)
    {
        dismiss()
    }
    
    @IBAction func photosButtonAction(sender: UIButton)
    {
        print("相册")
        let iPC = UIImagePickerController()
        iPC.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        iPC.delegate = self
        presentViewController(iPC, animated: true) { () -> Void in
                         print("complete")
                     }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        
        
    }
    
    
    @IBAction func backButtonAction(sender: UIButton)
    {
        if self.selectedArray.count != 0
        {
            for _ in 1...self.selectedArray.count
            {
                self.imageArray.removeLastObject()
            }
        }
        
        dismiss()
    }
    
    func dismiss()
    {
        self.delegate.popViewControllerPhotosArray(self.imageArray)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
