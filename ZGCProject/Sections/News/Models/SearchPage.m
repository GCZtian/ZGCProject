//
//  SearchPage.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
    //@property (nonatomic, retain) NSString *searchTitle;

#import "SearchPage.h"

@implementation SearchPage

- (void)dealloc
{
    self.searchContent = nil;
    self.searchData = nil;
    self.searchPhoto = nil;
    self.searchTitle = nil;
    self.comCount = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.searchContent = dic[@"scont"];
        self.searchData = dic[@"sdate"];
        self.searchPhoto = dic[@"imgsrc2"];
        self.searchTitle = dic[@"stitle"];
        if ([dic[@"comment_num"] intValue] == 0) {
            NSString *string = @"抢沙发";
            self.comCount = string;
        } else {
        NSString *string = [NSString stringWithFormat:@"%@评论", dic[@"comment_num"]];
        self.comCount = string;
        }
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@", _searchTitle];
}

@end
