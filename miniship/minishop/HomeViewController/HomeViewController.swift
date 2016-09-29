//
//  HomeViewController.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/9.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController,UIScrollViewDelegate {
    
    
    @IBOutlet weak var _titileLable: UILabel!
    
   
    @IBOutlet weak var _imageScrolleView: UIScrollView!
    
    @IBOutlet weak var _PageControl: UIPageControl!
    @IBOutlet weak var _goodsView: goodsView!
    @IBOutlet weak var _salesPromotionView: SalesPromotionView!
    @IBOutlet weak var _recommendedView: RecommendedView!
    
    @IBOutlet weak var _scrollView: UIScrollView!
    var imageArray : NSArray!
    var timer: Timer?
    var lableTitle : NSMutableArray!
    
    var viewWidth: CGFloat{
        return self.view.bounds.width
    }
    var index:CGFloat = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         imageArray = ["1-1.jpg","1-2.jpg","1-3.jpg","1-4.jpg"]
        let nextItem=UIBarButtonItem(title:"",style:.plain,target:self,action:nil);
        //  添加到到导航栏上
        self.navigationItem.leftBarButtonItem = nextItem;
     
    }
    
    override func viewDidLayoutSubviews()
    {
        resetUILayout()
        
    }
    
    func resetUILayout()
    {
        
        let height = _goodsView.frame.size.height + _goodsView.frame.origin.y
        _scrollView.contentSize  = CGSize(width: _scrollView.frame.size.width, height: height)
        imageScrollViewAction()
        
    }
    
    //TODO:imageScrollViewAction()
    func imageScrollViewAction()
    {
       
        
        _imageScrolleView.contentSize = CGSize(width: CGFloat(imageArray.count+2) * self.view.frame.width, height: _imageScrolleView.bounds.size.height)
        _imageScrolleView.showsHorizontalScrollIndicator = false
        _imageScrolleView.delegate = self
        _imageScrolleView.isPagingEnabled = true
        
        for i in 1...imageArray.count {
            
            let imgView: UIImageView = UIImageView(frame: CGRect(x: CGFloat(i) * self.view.frame.width, y: 0, width: self.view.frame.width, height: _imageScrolleView.bounds.size.height))
            
            imgView.image = UIImage(named: imageArray[i-1] as!String)
            _imageScrolleView.addSubview(imgView)
            
            imgView.isUserInteractionEnabled = true
            
            let singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.imageViewTouch))
            imgView.addGestureRecognizer(singleTap)
      
        }
        
        let imgView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: _imageScrolleView.bounds.size.height))
        imgView.image = UIImage(named: imageArray.lastObject as!String)
        imgView.isUserInteractionEnabled = true
        _imageScrolleView.addSubview(imgView)
        
        let imgView2: UIImageView = UIImageView(frame: CGRect(x: self.view.frame.width * 5, y: 0, width: self.view.frame.width, height: _imageScrolleView.bounds.size.height))
        imgView2.image = UIImage(named: imageArray.firstObject as!String)
        imgView2.isUserInteractionEnabled = true
        _imageScrolleView.addSubview(imgView2)
        
        _imageScrolleView.setContentOffset(CGPoint(x: self.view.frame.width, y: 0), animated: false)
        
        
    }

    func imageViewTouch()
    {
        let page = Int(_PageControl.currentPage)
        
        switch  page {
            
        case 0:
            print(page)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let target = storyboard.instantiateViewController(withIdentifier: "imageViewController")
            self.navigationController?.pushViewController(target, animated:true)
        case 1:
            print(page)
            
        case 2:
            print(page)
            
        case 3:
            print(page)
            
        default:
            "default"
        }
        
    }
    
    //TODO:UIScrollViewDelegate
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {

        let scrollviewW =  _imageScrolleView.frame.size.width
        
        let page = Int((_imageScrolleView.contentOffset.x + CGFloat( scrollviewW / 2)) / scrollviewW)
    
        _PageControl.currentPage = page - 1
        
    }
   
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }


    
    //MARK:addTimer()
        func addTimer(){
    
            timer = Timer.scheduledTimer(timeInterval: 1.5,
                target:self,selector:#selector(HomeViewController.nextPage),
                userInfo:nil,repeats:true)
        }
    
        func nextPage(){
            
            index = index+1
            
            if CGFloat(index) < CGFloat(imageArray.count+1)
            {
                animation()
            }
            else
            {
                index = 1
                animation()
            }
        }
        func animation()
        {
            var page = Int(_PageControl.currentPage)
        
            if (page == imageArray.count-1)
            {
                page = 0
            }
            else
            {
                page = page+1
            }
    
            UIView.animate(withDuration: 0.5, animations: { [unowned self] () -> Void in
                self._imageScrolleView.setContentOffset(CGPoint(x: self.viewWidth*self.index , y: 0), animated: false)
                })
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let w = scrollView.frame.width
        
        let page : Int = Int(_imageScrolleView.contentOffset.x/w)
        if page == 0 {
            _imageScrolleView.setContentOffset(CGPoint(x: CGFloat(imageArray.count) * w, y: 0), animated: false)
            
        } else if page == imageArray.count+1 {
            _imageScrolleView.setContentOffset(CGPoint(x: w, y: 0), animated: false)
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
