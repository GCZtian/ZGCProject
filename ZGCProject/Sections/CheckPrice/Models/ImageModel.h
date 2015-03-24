//
//  ImageModel.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic, retain) NSString *picSrcString;
@property (nonatomic, retain) NSString *bigPicString;

- (id)initWithDic:(NSDictionary *)dic;

@end
