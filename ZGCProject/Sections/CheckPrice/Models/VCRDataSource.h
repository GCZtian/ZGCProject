//
//  VCRDataSource.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCRDataSource : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *pubdate;
@property (nonatomic, retain) NSString *hits;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *vId;

- (id)initWithDic:(NSDictionary *)dic;

@end
