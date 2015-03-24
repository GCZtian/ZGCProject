//
//  HotListViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@interface HotListViewController : UIViewController

@property (nonatomic, retain) NSString *topName;
@property (nonatomic, retain) NSString *subcateId;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSString *allNum;
@property (nonatomic, retain) NSMutableArray *hotListArray;
@property (nonatomic, assign) int i, indefier;;
@property (nonatomic, retain) UITableView *HotList;

@end
