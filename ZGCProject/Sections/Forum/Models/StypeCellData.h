//
//  StypeCellData.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StypeCellData : NSObject

@property (nonatomic, retain) NSArray *pics;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *reply;
@property (nonatomic, retain) NSString *lastDate;
@property (nonatomic, retain) NSString *bookId;
@property (nonatomic, retain) NSString *good;
@property (nonatomic, retain) NSString *toptype;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
