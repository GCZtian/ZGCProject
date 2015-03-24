//
//  BBS.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBS : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *authorName;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *comCount;
@property (nonatomic, retain) NSString *detailUrl;
@property (nonatomic, retain) NSString *type;

- (id)initDictionary:(NSDictionary *)dic;


@end
