//
//  PostCellData.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-9.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostCellData : NSObject

@property (nonatomic, retain) NSArray *pic_url;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *reply;
@property (nonatomic, retain) NSString *lastDate;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *bbs;
@property (nonatomic, retain) NSString *bbsName;
@property (nonatomic, retain) NSString *boatdId;
@property (nonatomic, retain) NSString *bookId;
@property (nonatomic, retain) NSString *good;
@property (nonatomic, retain) NSNumber *favourNum;
@property (nonatomic, retain) NSString *toptype;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
