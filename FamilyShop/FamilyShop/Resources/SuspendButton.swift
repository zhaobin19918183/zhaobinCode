//
//  SuspendButton.swift
//  NBALive
//
//  Created by Zhao.bin on 16/10/12.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class SuspendButton: UIWindow {

    var button:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // ...
    
        
        
    }
    func test()
    {
        print("1111")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        button = UIButton(type:.contactAdd)
        self.backgroundColor = UIColor.red
        //设置按钮位置和大小
        button.frame = CGRect(x:0, y:0 , width:60, height:60)
        //设置按钮文字
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(self.test), for: UIControlEvents.touchDown)
        self.addSubview(button)
//        fatalError("init(coder:) has not been implemented")
    }
 
    
 
    


}
