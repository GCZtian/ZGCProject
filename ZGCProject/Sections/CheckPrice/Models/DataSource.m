//
//  DataSource.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DataSource.h"

#import <AFNetworking/AFNetworking.h>

@implementation DataSource

- (void)readData:(NSURL *)url
{
    //创建AFNetworking的请求操作
    AFHTTPRequestOperation *opertion = [[[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]] autorelease];
    
    //设置AFNetworking返回的数据 自动进行json解析
    opertion.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [opertion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([_delegate respondsToSelector:@selector(viewload:)]) {
            [_delegate viewload:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    [opertion start];
}

@end
