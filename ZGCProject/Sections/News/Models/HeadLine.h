//
//  HeadLine.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HeadLine : NSObject

@property (nonatomic, retain) NSString *headLineTitle;//标题
@property (nonatomic, retain) NSString *headLinePhoto;//图片url
@property (nonatomic, retain) NSString *headLineDate;//日期
@property (nonatomic, retain) NSString *headLineCount;//评论个数
@property (nonatomic, retain) NSString *detailUrlString;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *pictureCount;//图片的个数
@property (nonatomic, retain) NSArray *mPictureArray;//数组存放图片
@property (nonatomic, retain) NSString *selfId;

- (id)initDictionary:(NSDictionary *)dic;

@end
