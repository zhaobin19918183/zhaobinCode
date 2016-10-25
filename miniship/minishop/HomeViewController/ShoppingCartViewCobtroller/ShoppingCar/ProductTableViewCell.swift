//
//  ProductTableViewCell.swift
//  minishop
//
//  Created by Zhao.bin on 16/3/15.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var _nameLable: UILabel!
    @IBOutlet weak var _moneyLable: UILabel!
    @IBOutlet weak var _weightLable: UILabel!
    @IBOutlet weak var _selectLable: UILabel!
    @IBOutlet weak var _productImageView: UIImageView!
    var index:Int!
    var section:Int!
    
    var animationLayers: [CALayer]?
    var animationBigLayers: [CALayer]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   

    
    @IBAction func deleteProductAction(_ sender: UIButton)
    {
       
        print("section==\(section)","index==\(index)")
        
       
    }
  
    @IBAction func addProductAction(_ sender: UIButton)
    {
       print("section==\(section)","index==\(index)")
      
       addProductsAnimation(_productImageView)
      
    }
//    //MARK:动画效果
    func addProductsAnimation(_ imageView: UIImageView) {
        
        if (self.animationLayers == nil)
        {
            self.animationLayers = [CALayer]();
        }
        
        let frame = imageView.convert(imageView.bounds, to:self)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position;
        
        let p3 = CGPoint(x: self.width - 20 , y: self.layer.bounds.size.height * 4 + 20);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
       // CGPathMoveToPoint(path, nil, p1.x, p1.y);
       // CGPathAddCurveToPoint(path, nil, p1.x, p1.y - 30, p3.x, p1.y - 30, p3.x, p3.y);
       // positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
       // groupAnimation.delegate = self;
        
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
