//
//  CSMoreNewsViewController.swift
//  CSNavTabBarController-Demo
//
//  Created by iMacHCS on 15/11/19.
//  Copyright © 2015年 CS. All rights reserved.
//

import UIKit

class CSMoreNewsViewController: CSNavTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CSNavTabBarController"
        
        let first = FirstViewController()
        first.title = "头条"
        
        //swift中关联xib的viewController必须使用nibName:bundle:实例化，否则xib未能加载出来
        let second = SecondViewController(nibName: "SecondViewController", bundle: nil)
        second.title = "热点"
        
        let third = ThirdViewController()
        third.title = "深圳"
        
        let fourth = TextViewController()
        fourth.title = "云课堂"
        
        let fifth = TextViewController()
        fifth.title = "图片"
        
        let sixth = TextViewController()
        sixth.title = "科技"
        
        let seventh = TextViewController()
        seventh.title = "轻松一刻"
        
        let eighth = TextViewController()
        eighth.title = "汽车"
        
        let ninth = TextViewController()
        ninth.title = "房产"
        
        let tenth = TextViewController()
        tenth.title = "军事"
        
        let eleven = TextViewController()
        eleven.title = "历史"
        
        let twelve = TextViewController()
        twelve.title = "暴雪游戏"
        
        let thirteen = TextViewController()
        thirteen.title = "漫画"
        
        let fourteen = TextViewController()
        fourteen.title = "时尚"
        
        let fifteen = TextViewController()
        fifteen.title = "亲子"
        
        let sixteen = TextViewController()
        sixteen.title = "中国足球"
        
        let seventeen = TextViewController()
        seventeen.title = "值得买"
        
        let eighteen = TextViewController()
        eighteen.title = "CBA"
        
        let nineteen = TextViewController()
        nineteen.title = "彩票"
        
        let twenty = TextViewController()
        twenty.title = "政治"
        
        let twentyOne = TextViewController()
        twentyOne.title = "漫画"
        
        let twentyTwo = TextViewController()
        twentyTwo.title = "游戏"
        
        let twentyThree = TextViewController()
        twentyThree.title = "影视"
        
        let twentyFour = TextViewController()
        twentyFour.title = "财经"
        
        let twentyFive = TextViewController()
        twentyFive.title = "葡萄酒"
        
        let twentySix = TextViewController()
        twentySix.title = "教育"
        
        let twentySeven = TextViewController()
        twentySeven.title = "中国足球"
        
        let twentyEight = TextViewController()
        twentyEight.title = "博客"
        
        let twentyNine = TextViewController()
        twentyNine.title = "情感"
        
        let thirty = TextViewController()
        thirty.title = "艺术"
        
        let thirtyOne = TextViewController()
        thirtyOne.title = "旅游"
        
        let thirtyTwo = TextViewController()
        thirtyTwo.title = "你好菜鸟"
        
        let thirtyThree = TextViewController()
        thirtyThree.title = "数码"
        
        let thirtyFour = TextViewController()
        thirtyFour.title = "移动互联"
        
        let thirtyFive = TextViewController()
        thirtyFive.title = "跑步"
        
        let thirtySix = TextViewController()
        thirtySix.title = "体育"
        
        let thirtySeven = TextViewController()
        thirtySeven.title = "读书"
        
        let thirtyEight = TextViewController()
        thirtyEight.title = "段子"
        
        let thirtyNine = TextViewController()
        thirtyNine.title = "家居"
        
        self.viewControllers = [first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth]
        
        self.moreViewControllers = [eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyOne, twentyTwo, twentyThree, twentyFour, twentyFive, twentySix, twentySeven, twentyEight, twentyNine, thirty, thirtyOne, thirtyTwo, thirtyThree, thirtyFour, thirtyFive, thirtySix, thirtySeven, thirtyEight, thirtyNine,first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth]
        self.disabledCount = 1
    }
    
    
    override func navTabBar(navTabBar: CSNavTabBar, didClickArrowButton arrowButton: UIButton) {
        super.navTabBar(navTabBar, didClickArrowButton: arrowButton)
        
        if arrowButton.selected == false {
            var myClasses = [[String: String]]()
            var moreClasses = [[String: String]]()
            for vc in self.viewControllers {
                let className = NSStringFromClass(object_getClass(vc))
                let title = vc.title != nil ? vc.title! : ""
                myClasses.append(["className": className, "title": title])
            }
            for vc in self.moreViewControllers {
                let className = NSStringFromClass(object_getClass(vc))
                let title = vc.title != nil ? vc.title! : ""
                moreClasses.append(["className": className, "title": title])
            }
            self.saveChange = true
         
        }
    }
    
    
}

