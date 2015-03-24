//
//  DetaiParSource.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetaiParSource.h"

@implementation DetaiParSource

- (void)dealloc
{
    self.name = nil;
    self.value = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.value = dic[@"value"];
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, value:%@", _name, _value];
}

@end
