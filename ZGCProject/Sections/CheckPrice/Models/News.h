//
//  News.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *reviewNum;
@property (nonatomic, retain) NSString *picString;
@property (nonatomic, retain) NSString *docId;

- (id)initWithDic:(NSDictionary *)dic;

@end
