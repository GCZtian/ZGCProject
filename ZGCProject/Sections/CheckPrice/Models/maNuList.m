//
//  maNuList.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/9.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "maNuList.h"

@implementation maNuList

- (void)dealloc
{
    self.phonePic = nil;
    self.names = nil;
    self.indexes = nil;
    self.title = nil;
    self.headLine = nil;
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ indexes:%@", _names, _indexes];
}

@end
