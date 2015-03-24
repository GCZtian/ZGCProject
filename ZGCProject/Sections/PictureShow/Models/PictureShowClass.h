//
//  PictureShowClass.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/10.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureShowClass : NSObject

@property (nonatomic, retain) NSString *pictureTitle;//标题
@property (nonatomic, retain) NSString *comNum;//评论个数
@property (nonatomic, retain) NSString *data;//时间
@property (nonatomic, retain) id pictureMArray;//存放图片
@property (nonatomic, retain) NSString *pictureCount;//图片的个数
@property (nonatomic, retain) NSString *detailUrl;//详情url

@end
