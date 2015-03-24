//
//  Evaluating.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "Evaluating.h"

@implementation Evaluating
- (void)dealloc
{
    self.picSrcOne = nil;
    self.proId = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.picSrcOne = dic[@"picSrc"];
        self.proId = dic[@"proId"];
    }
    return self;
}

@end
