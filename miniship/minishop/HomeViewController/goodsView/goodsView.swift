
//
//  goodsView.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/10.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class goodsView: UIView {

    @IBOutlet var myUIView: goodsView!
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("goodsView", owner:self,options:nil)
        self.addSubview(myUIView)

    }
    

}
