//
//  DetailViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;

@interface ListViewContrioller : UIViewController

@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSString *subID;
@property (nonatomic, retain) NSString *manuId, *urlString;
@property (nonatomic, retain) NSMutableArray *listArray;
@property (nonatomic, retain) NSString *allNum;
@property (nonatomic, assign) int i;
@property (nonatomic, retain) UITableView *detailView;
@property (nonatomic, retain) NSString *keyWord;

@end
