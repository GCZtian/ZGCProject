//
//  Detal.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detal : NSObject

@property (nonatomic, retain) NSString *mainName;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSString *ID;

- (id)initWithDic:(NSDictionary *)dic;
@end
