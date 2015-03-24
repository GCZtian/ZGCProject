//
//  News.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "News.h"

@implementation News

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.picString = dic[@"pic"];
        self.reviewNum = [NSString stringWithFormat:@"%@评论", dic[@"reviewNum"]];
        self.date = dic[@"date"];
        self.docId = dic[@"docId"];
    }
    return self;
}

@end
