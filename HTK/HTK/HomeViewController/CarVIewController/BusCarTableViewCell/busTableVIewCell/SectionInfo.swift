//
//  SectionInfo.swift
//  表格动画手势示例
//
//  Created by Semper Idem on 14-10-22.
//  Copyright (c) 2014年 星夜暮晨. All rights reserved.
//

import Foundation

// 定义了分节表头的一系列属性、方法
class SectionInfo: NSObject {
    var open: Bool!
    var play: Play!
    var headerView: SectionHeaderView!
    
    var rowHeights = NSMutableArray()
    
    func countOfRowHeights() -> Int {
        return self.rowHeights.count
    }
    
    func objectInRowHeightsAtIndex(_ idx: Int) -> AnyObject {
        return self.rowHeights[idx] as AnyObject
    }
    
    func insertObject(_ anObject: AnyObject, inRowHeightsAtIndex: Int) {
        self.rowHeights.insert(anObject, at: inRowHeightsAtIndex)
    }
    
    func insertRowHeights(_ rowHeightArray: NSArray, atIndexes: IndexSet) {
        self.rowHeights.insert(rowHeightArray as [AnyObject], at: atIndexes)
    }
    
    func removeObjectFromRowHeightsAtIndex(_ idx: Int) {
        self.rowHeights.removeObject(at: idx)
    }
    
    func removeRowHeightsAtIndexes(_ indexes: IndexSet) {
        self.rowHeights.removeObjects(at: indexes)
    }
    
    func replaceObjectInRowHeightsAtIndex(_ idx: Int, withObject: AnyObject) {
        self.rowHeights[idx] = withObject
    }
    
    func replaceRowHeightsAtIndexes(_ indexes: IndexSet, withRowHeight: NSArray) {
        self.rowHeights.replaceObjects(at: indexes, with: withRowHeight as [AnyObject])
    }
}
