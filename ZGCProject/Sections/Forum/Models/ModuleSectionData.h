//
//  ModuleSectionData.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleSectionData : NSObject

@property (nonatomic, retain) NSString *sectionName;
@property (nonatomic, retain) NSString *sectionIntro;
@property (nonatomic, retain) NSArray *cellArray;
@property (nonatomic, retain) NSString *pic;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
