//
//  CSExtension.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

extension NSString {
    func textSizeWithFont(font: UIFont) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let options = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect = self.boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max), options: options, attributes: attributes, context: nil)
        return rect.size
    }
}
/*
// 获取某个view的背景图
+(UIImage *)imageFromView:(UIView*)theView
{
UIGraphicsBeginImageContextWithOptions(theView.bounds.size, theView.opaque, 0.0);
CGContextRef context = UIGraphicsGetCurrentContext();
[theView.layer renderInContext:context];
UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

return theImage;
}
*/
extension UIView {
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        self.layer.renderInContext(context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.height
        }
        set {
            self.frame.origin.y = newValue - self.frame.height
        }
    }
    var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.width
        }
    }
    var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
}// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com