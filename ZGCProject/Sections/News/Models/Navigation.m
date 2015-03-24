//
//  Navigation.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "Navigation.h"

@implementation Navigation

- (void)dealloc
{
    self.navigationID = nil;
    self.navigationName = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.navigationID = dic[@"id"];
        self.navigationName = dic[@"name"];
    }
    return self;
}


@end
