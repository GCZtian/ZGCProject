//
//  ModuleSectionData.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ModuleSectionData.h"

@implementation ModuleSectionData

- (void)dealloc
{
    self.sectionName = nil;
    self.sectionIntro = nil;
    self.cellArray = nil;
    self.pic = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.sectionName = dic[@"name"];
        self.sectionIntro = dic[@"intro"];
        self.cellArray = dic[@"list"];
        self.pic = dic[@"pic"];
    }
    return self;
}

@end
