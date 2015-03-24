//
//  DetailList.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailList : NSObject

@property (nonatomic, retain) NSString *imageString;
@property (nonatomic, retain) NSNumber *picNumber;
@property (nonatomic, retain) NSString *priceRange;
@property (nonatomic, retain) NSString *nameString;
@property (nonatomic, retain) NSString *sellNum;
@property (nonatomic, retain) NSString *briefString;
@property (nonatomic, retain) NSString *seriesProNum;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *idString;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
