//
//  ModuleCellData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ModuleCellData.h"

@implementation ModuleCellData

- (void)dealloc
{
    self.bbsName = nil;
    self.paramDic = nil;
    self.totalDic = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.bbsName = dic[@"name"];
        self.paramDic = dic[@"param"];
        self.totalDic = dic[@"total"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"bbsName:%@, paramDic:%@, totalDic:%@", _bbsName, _paramDic, _totalDic];
}

@end
