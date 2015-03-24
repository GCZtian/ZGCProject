//
//  PictureShowClass.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/10.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "PictureShowClass.h"

@implementation PictureShowClass

- (void)dealloc
{
    self.pictureTitle = nil;
    self.comNum = nil;
    self.data = nil;
    self.pictureMArray = nil;
    self.pictureCount = nil;
    self.detailUrl = nil;
    
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title: %@", _pictureTitle];
}


@end
