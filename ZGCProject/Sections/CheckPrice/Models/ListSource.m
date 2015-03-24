//
//  ListSource.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/10.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ListSource.h"

@implementation ListSource

- (void)dealloc
{
    self.price = nil;
    self.imageUrl = nil;
    self.seriesId = nil;
    self.nameAndSeriesProNum = nil;
    self.name = nil;
    self.ID = nil;
    self.mainId = nil;
    self.subcateId = nil;
    self.reviewNum = nil;
    self.comment = nil;
    self.thisWeekHit = nil;
    self.userComentStar = nil;
    self.mark = nil;
    self.priceMore = nil;
    self.topName = nil;
    self.topNumber = nil;
    [super dealloc];
}

- (id)initDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.price = [NSString stringWithFormat:@"%@%@", dic[@"mark"], dic[@"price"]];
        if ([dic[@"seriesProNum"] isEqualToString:@""]) {
            self.nameAndSeriesProNum = dic[@"name"];
        } else {
            self.nameAndSeriesProNum = [NSString stringWithFormat:@"%@(共%@款)", dic[@"name"], dic[@"seriesProNum"]];
        }
        if ([dic[@"priceMore"] isEqualToString:@""]) {
            self.thisWeekHit = [NSString stringWithFormat:@"周关注量%.1f万次", [dic[@"thisWeekHit"] floatValue] / 10000];
        } else {
            self.thisWeekHit = [NSString stringWithFormat:@"周关注量%.1f万次\n%@", [dic[@"thisWeekHit"] floatValue] / 10000.0, dic[@"priceMore"]];
        }
        
        self.comment = [NSString stringWithFormat:@"%@点评", dic[@"reviewNum"]];
        self.imageUrl = dic[@"pic"];
        self.userComentStar = dic[@"userCommStar"];
        if ([dic[@"award"] intValue] > 0) {
            self.award = [dic[@"award"] intValue];
        }
        self.topNumber = dic[@"topNumber"];
        self.seriesId = dic[@"seriesId"];
        self.ID = dic[@"id"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ thisWeek:%@", _name, _thisWeekHit];
}
@end
