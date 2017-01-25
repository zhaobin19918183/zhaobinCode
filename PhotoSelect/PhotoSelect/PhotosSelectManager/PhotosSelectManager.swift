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
    func popViewControllerPhotosArray(_ photosImageArray : NSMutableArray)
}
class PhotosSelectManager: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberPhotos: UIButton!
    var delegate : popViewControllerDelegate!
    
    @IBOutlet weak var photosButton: UIButton!
    
    //资源库管理类
    var assetsFetchResults =  PHFetchResult<AnyObject>()
    //保存照片集合
    var PHIassets = PHImageManager()
    var asset = PHAsset()
    var options = PHFetchOptions()
    var imageManager  = PHImageManager()
    var imageArray = NSMutableArray()
    var selectedArray = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil) as! PHFetchResult<AnyObject>
        collectionView.register(UINib(nibName: "PhotosCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCellId")
        collectionView.allowsMultipleSelection = true
        // Do any additional setup after loading the view.\
        
        
        print(2)
        
    }
    //MARK:CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return assetsFetchResults.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellId", for: indexPath) as? PhotosCollectionCell
        
        asset = assetsFetchResults[(indexPath as NSIndexPath).row] as! PHAsset
        
        //        imageManager.requestImageDataForAsset(asset, options: PHImageRequestOptions.init()) { (data, string, imageOrientation, dic) in
        //           print(data)
        //
        //        }
        imageManager.requestImage(for: asset, targetSize:PHImageManagerMaximumSize,contentMode: PHImageContentMode.aspectFit, options: nil) { (resultimage,  info) in
            
            cell?.backgroundImageVIew.image = resultimage
            
        }
        
        if cell?.isSelected == true {
            cell?.selectImage.image = UIImage(named:"selected.png")
        }
        else
        {
           cell?.selectImage.image = UIImage(named:"select.png")
        }
        
        return cell!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionCell
//        cell.imageLable!.font = UIFont(name: "iconfont", size: 20)
//        cell.imageLable!.text = "\u{e660}"
        cell.selectImage.image = UIImage(named:"selected.png")
        self.imageArray.add(cell.backgroundImageVIew.image!)
        self.selectedArray.add(cell.backgroundImageVIew.image!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionCell
//        cell.imageLable!.font = UIFont(name: "iconfont", size: 20)
//        cell.imageLable!.text = "\u{e661}"
        cell.selectImage.image = UIImage(named:"select.png")
        self.imageArray.remove(cell.backgroundImageVIew.image!)
        
    }
    //MARK:取出图片按照图片大小确定cell 的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        //        let  string =  NSUserDefaults.standardUserDefaults().valueForKey("photos") as! String
        //        let array = HelperManager.convertStringToAnyObject(string) as! NSMutableArray
        //
        //        let decodedData = NSData(base64EncodedString:array.objectAtIndex(indexPath.row) as! String, options:NSDataBase64DecodingOptions())
        //        let decodedimage = UIImage(data: decodedData!)! as UIImage
        //        print(decodedimage.size.width)
        return CGSize(width: 120, height:120)
    }
    @IBAction func numberPhotosAction(_ sender: UIButton)
    {
        dismiss()
    }
    
    @IBAction func photosButtonAction(_ sender: UIButton)
    {
        print("相册")
        let iPC = UIImagePickerController()
        iPC.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        iPC.delegate = self
        present(iPC, animated: true) { () -> Void in
                         print("complete")
                     }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        
        
    }
    
    
    @IBAction func backButtonAction(_ sender: UIButton)
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
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
