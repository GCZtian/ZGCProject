    //
    //  HeadLine.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/8.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "HeadLine.h"

@implementation HeadLine


- (void)dealloc
{
    self.selfId = nil;
    self.headLineTitle = nil;
    self.headLinePhoto = nil;
    self.headLineDate = nil;
    self.headLineCount = nil;
    self.detailUrlString = nil;
    self.type = nil;
    self.pictureCount = nil;
    self.mPictureArray = nil;
    [super dealloc];
}

- (id)initDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        self.selfId = dic[@"id"];
        self.headLineTitle = dic[@"stitle"];
        self.headLinePhoto = dic[@"imgsrc2"];
        NSString *dataString = [dic[@"sdate"] substringWithRange:NSMakeRange(5, 5)];
        
        self.headLineDate = dataString;
        if ([dic[@"comment_num"] intValue] == 0) {
            NSString *mString = @"抢沙发";
            self.headLineCount = mString;
        } else {
            NSString *mString = [NSString stringWithFormat:@"%@评论", dic[@"comment_num"]];
            self.headLineCount = mString;
        }
        self.detailUrlString = dic[@"url"];
        NSString *pictureCountString = [NSString stringWithFormat:@"%@图", dic[@"pic_num"]];
        self.pictureCount = pictureCountString;
        self.type = dic[@"type"];
        self.mPictureArray = dic[@"pics"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title : %@, data: %@", _headLineTitle, _headLineDate];
    
}

@end
