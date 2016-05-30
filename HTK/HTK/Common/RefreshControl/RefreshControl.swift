//
//  RefreshControl.swift
//  HTK
//
//  Created by Zhao.bin on 16/5/30.
//  Copyright © 2016年 赵斌. All rights reserved.
//

import UIKit


class RefreshControl: UIRefreshControl {
    
    var customView: UIView!
    
    var labelsArray: Array<UILabel> = []
    
    var currentColorIndex = 0
    
    var currentLabelIndex = 0
    
    var timer: NSTimer!
 
    required override init(){
        
        super.init()
        resetUILayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func  resetUILayout()
    {
        self.addTarget(self, action: #selector(refreshData),
                       forControlEvents: UIControlEvents.ValueChanged)
        
        //背景色和tint颜色都要清除,保证自定义下拉视图高度自适应
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.clearColor()

        loadData()
        
        //加载自定义刷新界面
        loadCustomRefreshView()
    }

    //自定义刷新界面
    func loadCustomRefreshView() {
        let refreshContents = NSBundle.mainBundle().loadNibNamed("Refresh",
                                                                 owner: self, options: nil)
        
        customView = refreshContents[0] as! UIView
        customView.frame = self.bounds
        for i in 0 ..< customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        self.addSubview(customView)
    }

    
    // 刷新数据
    func refreshData() {
        self.labelsArray[0].text = "数"
        self.labelsArray[1].text = "据"
        self.labelsArray[2].text = "加"
        self.labelsArray[3].text = "载"
        self.labelsArray[4].text = "......"
        //  self.labelsArray[5].text = "..."
        
        //播放动画
        playAnimateRefresh()
        //模拟加载数据
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self,
                                                       selector: #selector(loadData), userInfo: nil, repeats: true)
    }
    
    //播放文字动画
    func playAnimateRefresh() {
        //文字放大，变色动画
        UIView.animateWithDuration(0.15, delay: 0.0,
                                   options: .CurveLinear, animations: { () -> Void in
                                    
                                    self.labelsArray[self.currentLabelIndex].transform =
                                        CGAffineTransformMakeScale(1.5, 1.5)
                                    self.labelsArray[self.currentLabelIndex].textColor =
                                        self.getNextColor()
                                    
            }, completion: { (finished) -> Void in
                
                //文字样式还原动画
                UIView.animateWithDuration(0.1, delay: 0.0,
                    options: .CurveLinear, animations: { () -> Void in
                        
                        self.labelsArray[self.currentLabelIndex].transform =
                        CGAffineTransformIdentity
                        self.labelsArray[self.currentLabelIndex].textColor =
                            UIColor.blackColor()
                        
                    }, completion: { (finished) -> Void in
                        self.currentLabelIndex += 1
                        
                        if self.currentLabelIndex == self.labelsArray.count - 1 {
                            self.currentLabelIndex = 0
                        }
                        
                        //没加载完则继续播放动画
                        if self.refreshing {
                            self.playAnimateRefresh()
                        }else{
                            self.currentLabelIndex = 0
                        }
                })
        })
    }

    func loadData() {
        self.endRefreshing()
        timer?.invalidate()
        timer = nil
    }
    
    
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [UIColor.magentaColor(),
                                           UIColor.brownColor(), UIColor.yellowColor(), UIColor.redColor(),
                                           UIColor.greenColor(), UIColor.blueColor(), UIColor.orangeColor()]
        
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        
        return returnColor
    }
   



}
