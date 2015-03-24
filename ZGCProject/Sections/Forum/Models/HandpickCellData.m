//
//  HandpickCellData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HandpickCellData.h"

@implementation HandpickCellData

- (void)dealloc
{
    self.title = nil;
    self.pics = nil;
    self.logo = nil;
    self.author = nil;
    self.reply = nil;
    self.lastDate = nil;
    self.bbs = nil;
    self.boardId = nil;
    self.bookId = nil;
    self.good = nil;
    self.toptype = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.pics = dic[@"pics"];
        self.logo = dic[@"photo"];
        self.author = dic[@"nickname"];
        self.bbs = dic[@"bbs"];
        self.bookId = dic[@"bookid"];
        self.boardId = dic[@"boardid"];
        self.good = dic[@"good"];
        self.toptype = dic[@"toptype"];
        self.reply = dic[@"reply"];
        //最后更新时间:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GTM"]];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[dateFormatter dateFromString:dic[@"date"]]];
        [dateFormatter release];
        NSString *dateString = nil;
        if (timeInterval < 60) {
            dateString = @"刚刚";
        } else if (timeInterval < 3600) {
            dateString = [NSString stringWithFormat:@"%.lf分钟前", timeInterval / 60];
        } else if (timeInterval < 3600 * 24) {
            dateString = [NSString stringWithFormat:@"%.lf小时前", timeInterval / 3600];
        } else if (timeInterval < 3600 * 48) {
            dateString = @"1天前";
        } else {
            dateString = [dic[@"date"] substringToIndex:10];
        }
        self.lastDate = dateString;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@, reply:%@", _title, _reply];
}

@end
