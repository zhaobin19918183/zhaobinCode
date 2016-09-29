//
//  SalesPromotionView.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/10.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class SalesPromotionView: UIView {


   
    @IBOutlet var myUIView: UIView!

    
    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }

    func  resetUILayout()
    {
        
        Bundle.main.loadNibNamed("salesPromotionview", owner:self,options:nil)
        self.addSubview(myUIView)
        
    }

}
