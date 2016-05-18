//
//  CityEntity+CoreDataProperties.h
//  HTK
//
//  Created by Zhao.bin on 16/5/18.
//  Copyright © 2016年 赵斌. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CityEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cityString;

@end

NS_ASSUME_NONNULL_END
