//
//  ModuleForumsViewController.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleForumsViewController : UIViewController

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSNumber *collectNum;
@property (nonatomic, retain) NSNumber *postNum;
@property (nonatomic, retain) NSNumber *totalPage;
@property (nonatomic, retain) NSMutableArray *rowArray;
@property (nonatomic ,retain) NSString *bbsName;
@property (nonatomic, retain) NSString *bbs;
@property (nonatomic, retain) NSString *boardId;

@end
