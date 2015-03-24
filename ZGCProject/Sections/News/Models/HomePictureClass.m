//
//  HomePictureClass.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/10.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HomePictureClass.h"

@implementation HomePictureClass

- (void)dealloc
{
    self.homePic = nil;
    self.homeTit = nil;
    self.homeUrl = nil;
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@", _homeTit];
}

@end
