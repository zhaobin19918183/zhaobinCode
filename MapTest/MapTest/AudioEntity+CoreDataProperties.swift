//
//  AudioEntity+CoreDataProperties.swift
//  
//
//  Created by newland on 2017/12/11.
//
//

import Foundation
import CoreData


extension AudioEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AudioEntity> {
        return NSFetchRequest<AudioEntity>(entityName: "AudioEntity")
    }

    @NSManaged public var filelong: String?
    @NSManaged public var fileName: String?
    @NSManaged public var fileTime: NSDate?
    @NSManaged public var fileDistance: String?
    @NSManaged public var fileTimeLong: String?
    @NSManaged public var fileCoordinate: NSData?
    @NSManaged public var fuileNumber: NSData?
    @NSManaged public var filetime1: NSData?
    @NSManaged public var filetime2: NSData?
    @NSManaged public var filetime3: NSData?

}
