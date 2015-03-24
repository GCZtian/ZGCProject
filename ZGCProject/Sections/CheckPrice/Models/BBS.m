//
//  BBS.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "BBS.h"


@implementation BBS

- (void)dealloc
{
    self.title = nil;
    self.authorName = nil;
    self.data = nil;
    self.comCount = nil;
    self.detailUrl = nil;
    self.type = nil;
    [super dealloc];
}

- (id)initDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        if ([dic[@"title"] length] >= 40) {
            NSString *titleString = [dic[@"title"] substringToIndex:40];
            self.title = titleString;
        } else {
        self.title = dic[@"title"];
        }
        self.authorName = dic[@"nickname"];
        NSString *dataString = [dic[@"date"] substringToIndex:10];
        self.data = dataString;
        NSString *string = [NSString stringWithFormat:@"%@回", dic[@"reply"]];
        self.comCount = string;
        self.detailUrl = dic[@"url"];
        self.type = dic[@"type"];
    }
    return self;
}

@end
