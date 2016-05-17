//
//  WeatherEntity+CoreDataProperties.h
//  HTK
//
//  Created by 赵斌 on 16/5/17.
//  Copyright © 2016年 赵斌. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WeatherEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeatherEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *realtime;
@property (nullable, nonatomic, retain) NSDate *life;
@property (nullable, nonatomic, retain) NSDate *weather;
@property (nullable, nonatomic, retain) NSDate *pm25;

@end

NS_ASSUME_NONNULL_END
