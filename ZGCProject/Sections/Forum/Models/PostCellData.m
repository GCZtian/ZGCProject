//
//  PostCellData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-9.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "PostCellData.h"

@implementation PostCellData

- (void)dealloc
{
    self.title = nil;
    self.pic_url = nil;
    self.logo = nil;
    self.author = nil;
    self.reply = nil;
    self.lastDate = nil;
    self.date = nil;
    self.bbs = nil;
    self.bbsName = nil;
    self.boatdId = nil;
    self.bookId = nil;
    self.good = nil;
    self.favourNum = nil;
    self.toptype = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.pic_url = dic[@"pic_url"];
        self.logo = dic[@"photo"];
        self.author = dic[@"nickname"];
        self.bbs = dic[@"bbs"];
        self.bookId = dic[@"bookid"];
        self.boatdId = dic[@"boardid"];
        self.good = dic[@"good"];
        self.favourNum = dic[@"favourNum"];
        self.toptype = dic[@"toptype"];
        self.reply = dic[@"reply"];
        //最后更新时间:
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GTM"]];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[dateFormatter dateFromString:dic[@"lastdate"]]];
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
            dateString = [dic[@"lastdate"] substringToIndex:10];
        }
        self.lastDate = dateString;
        self.date = [dic[@"wdate"] substringToIndex:10];
        self.bbsName = dic[@"bbsname"];
    }
    return self;
}

@end
