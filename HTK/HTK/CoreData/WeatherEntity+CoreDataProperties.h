//
//  WeatherEntity+CoreDataProperties.h
//  HTK
//
//  Created by Zhao.bin on 16/5/19.
//  Copyright © 2016年 赵斌. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeatherEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *life;
@property (nullable, nonatomic, retain) NSData *pm25;
@property (nullable, nonatomic, retain) NSData *realtime;
@property (nullable, nonatomic, retain) NSData *weather;

@end

NS_ASSUME_NONNULL_END
