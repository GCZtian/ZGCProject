//
//  SearchResultData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "SearchResultData.h"

@implementation SearchResultData

- (void)dealloc
{
    self.bbs = nil;
    self.bbsname = nil;
    self.boardid = nil;
    self.bookid = nil;
    self.hits = nil;
    self.reply = nil;
    self.title = nil;
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"bbs_name"]) {
        self.bbs = value;
    }
}

@end
