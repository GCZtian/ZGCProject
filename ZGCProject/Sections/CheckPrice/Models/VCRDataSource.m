//
//  VCRDataSource.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "VCRDataSource.h"

@implementation VCRDataSource

- (void)dealloc
{
    self.title = nil;
    self.hits = nil;
    self.vId = nil;
    self.pubdate = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.vId = dic[@"vId"];
        self.pubdate = dic[@"pubdate"];
        self.pic = dic[@"pic"];
        self.hits = [NSString stringWithFormat:@"%@播放", dic[@"hits"]];
    }
    return self;
}

@end
