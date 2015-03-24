    //
    //  NewaDataHandle.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/11.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "NewaDataHandle.h"
#import <AFNetworking/AFNetworking.h>


@implementation NewaDataHandle

- (void)dealloc
{
    self.detaileView = nil;
    [super dealloc];
}

+ (NewaDataHandle *)defaultNewDataHandle
{
    static NewaDataHandle *newData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        newData = [[NewaDataHandle alloc] init];
        [newData readData:@"0" pageNumber:0];
    });
    return newData;
}

- (void)readData:(NSString *)selfId pageNumber:(NSInteger)page
{
        //创建AFNetworking的请求操作
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/docList.php?class_id=%@&page=%ld&vs=and380&retina=1", selfId, page + 1]]]];
    
        //设置AFNetworking返回的数据 自动进行json解析
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [
     operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject == nil) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无更多内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
        } else {
        [_netDataDelegate dataRead:responseObject];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
    }];
        //开启数据请求
    [operation start];
}


@end
