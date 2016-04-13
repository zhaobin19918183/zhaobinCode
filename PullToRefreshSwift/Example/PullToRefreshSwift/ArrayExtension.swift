//
//  ArrayExtention.swift
//  PullToRefreshSwift
//
//  Created by 波戸 勇二 on 12/11/14.
//  Copyright (c) 2014 Yuji Hato. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func shuffle() {
        for _ in 0..<self.count {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
