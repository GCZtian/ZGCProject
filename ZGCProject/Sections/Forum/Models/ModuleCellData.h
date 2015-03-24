//
//  ModuleCellData.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleCellData : NSObject

@property (nonatomic ,retain) NSString *bbsName;
@property (nonatomic, retain) NSDictionary *paramDic;
@property (nonatomic, retain) NSDictionary *totalDic;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
