//
//  DetaiParSource.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetaiParSource : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

- (id)initWithDic:(NSDictionary *)dic;
@end
