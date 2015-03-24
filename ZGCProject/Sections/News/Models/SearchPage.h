//
//  SearchPage.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchPage : NSObject

@property (nonatomic, retain) NSString *searchTitle;//标题
@property (nonatomic, retain) NSString *searchData;//日期
@property (nonatomic,retain) NSString *searchContent;//内容
@property (nonatomic,retain) NSString *searchPhoto;//图像
@property (nonatomic, retain) NSString *comCount;//评论个数

- (id)initWithDictionary:(NSDictionary *)dic;

@end
