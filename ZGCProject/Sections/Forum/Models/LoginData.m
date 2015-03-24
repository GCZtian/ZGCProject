//
//  LoginData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-16.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "LoginData.h"

@implementation LoginData

- (void)dealloc
{
    self.userName = nil;
    self.password = nil;
    [super dealloc];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

@end
