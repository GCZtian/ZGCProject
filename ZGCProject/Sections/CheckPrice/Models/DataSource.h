//
//  DataSource.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyDelegate <NSObject>

- (void)viewload:(id)response;

@end

@interface DataSource : NSObject

@property (nonatomic, assign) id<MyDelegate>delegate;

- (void)readData:(NSURL *)url;

@end
