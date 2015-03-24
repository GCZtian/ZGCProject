//
//  DetailList.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetailList.h"

@implementation DetailList

- (void)dealloc
{
    self.imageString = nil;
    self.picNumber = nil;
    self.nameString = nil;
    self.priceRange = nil;
    self.sellNum = nil;
    self.briefString = nil;
    self.seriesProNum = nil;
    self.price = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.imageString = dic[@"pic"];
        self.picNumber = dic[@"picNum"];
        if ([dic[@"sellNum"] isEqualToString:@""]) {
            self.sellNum = @"月销量 暂无 (仅参考)";
        } else {
            self.sellNum = [NSString stringWithFormat:@"月销量%.1f万 (仅参考)", [dic[@"sellNum"] intValue] / 10000.0];
        }
        self.briefString = dic[@"brief"];
        if (((NSString *)dic[@"seriesProNum"]) == nil) {
            self.price = [NSString stringWithFormat:@"￥%@", dic[@"price"]];
        } else {
            self.priceRange = [NSString stringWithFormat:@"￥%@", dic[@"priceRange"]];
        }
        if (((NSString *)dic[@"seriesProNum"]).length == 0) {
            self.nameString = dic[@"name"];
        } else {
            self.nameString = [NSString stringWithFormat:@"%@ (共%@款)", dic[@"name"], dic[@"seriesProNum"]];
        }
        self.idString = dic[@"id"];
        self.seriesProNum = dic[@"seriesProNum"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@", self.nameString];
}

@end
