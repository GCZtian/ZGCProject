//
//  NewaDataHandle.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/11.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetDataDelegate <NSObject>

- (void)dataRead:(id)response;

@end

@class DetailTableView;

@interface NewaDataHandle : NSObject

@property (nonatomic, assign) id<NetDataDelegate>netDataDelegate;
@property (nonatomic, retain) DetailTableView *detaileView;

- (void)readData:(NSString *)selfId pageNumber:(NSInteger)page;

+ (NewaDataHandle *)defaultNewDataHandle;

@end
