//
//  Navigation.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Navigation : NSObject

@property (nonatomic, retain) NSString *navigationID;
@property (nonatomic, retain) NSString *navigationName;

- (id)initWithDictionary:(NSDictionary *)dic;


@end
