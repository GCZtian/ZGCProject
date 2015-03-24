//
//  ExtraProsDataSource.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ExtraProsDataSource.h"

@implementation ExtraProsDataSource

- (void)dealloc
{
    self.price = nil;
    self.priceName = nil;
    self.name = nil;
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"名字:%@ ", _priceName];
}


@end
