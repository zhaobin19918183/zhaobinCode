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
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    required init(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)!
        resetUILayout()
        
    }
 
    @IBAction func recommendAction1(_ sender: UIButton)
    {
        print(1)
    }
    
    @IBAction func recommendAction2(_ sender: UIButton)
    {
        print(2)
    }
    
    @IBAction func recommendAction3(_ sender: UIButton)
    {
        print(3)
    }
    func  resetUILayout()
    {
        
        Bundle.main.loadNibNamed("recommendedview", owner:self,options:nil)
        self.addSubview(myUIView)
        
    }

}
