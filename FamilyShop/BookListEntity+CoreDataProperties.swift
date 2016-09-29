//
//  BookListEntity+CoreDataProperties.swift
//  FamilyShop
//
//  Created by Zhao.bin on 16/9/28.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import Foundation
import CoreData


extension BookListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookListEntity> {
        return NSFetchRequest<BookListEntity>(entityName: "BookListEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var date: String?

}
