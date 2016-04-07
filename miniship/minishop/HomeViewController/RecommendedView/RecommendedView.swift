//
//  RecommendedView.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/10.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class RecommendedView: UIView {

  
    @IBOutlet var myUIView: UIView!
    
    @IBOutlet weak var _recommendButton1: UIButton!
    
    @IBOutlet weak var _recommendButton2: UIButton!
    
    @IBOutlet weak var _recommendButton3: UIButton!
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
 
    @IBAction func recommendAction1(sender: UIButton)
    {
        print(1)
    }
    
    @IBAction func recommendAction2(sender: UIButton)
    {
        print(2)
    }
    
    @IBAction func recommendAction3(sender: UIButton)
    {
        print(3)
    }
    func  resetUILayout()
    {
        
        NSBundle.mainBundle().loadNibNamed("recommendedview", owner:self,options:nil)
        self.addSubview(myUIView)
        
    }

}
