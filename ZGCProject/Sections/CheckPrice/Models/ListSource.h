//
//  ListSource.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/10.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListSource : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *mark;
@property (nonatomic, retain) NSString *userComentStar;
@property (nonatomic, retain) NSString *mainId;
@property (nonatomic, retain) NSString *nameAndSeriesProNum;
@property (nonatomic, retain) NSString *reviewNum;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *subcateId;
@property (nonatomic, retain) NSString *thisWeekHit;
@property (nonatomic, retain) NSString *seriesId;
@property (nonatomic, retain) NSString *priceMore;
@property (nonatomic, assign) int award;
@property (nonatomic, retain) NSString *topName;
@property (nonatomic, retain) NSNumber *topNumber;
- (id)initDictionary:(NSDictionary *)dic;


@end
