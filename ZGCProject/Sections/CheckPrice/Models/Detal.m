//
//  Detal.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "Detal.h"

@implementation Detal

- (void)dealloc
{
    self.name = nil;
    self.mainName = nil;
    self.value = nil;
    self.ID = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.name = dic[@"name"];
        self.value = dic[@"value"];
        self.ID = dic[@"id"];
    }
    return self;
}


@end
