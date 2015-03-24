//
//  ImageModel.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

- (void)dealloc
{
    self.picSrcString = nil;
    self.bigPicString = nil;
    [super dealloc];
}

- (id)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        if (dic[@"images_src"] != nil) {
            self.bigPicString = dic[@"images_src"];
        } else {
            self.bigPicString = dic[@"bigPic"];
        }
    }
    return self;
}

@end
