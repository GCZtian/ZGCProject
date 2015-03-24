//
//  ViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class MJNIndexView;
@interface RankListViewController : UIViewController

@property (nonatomic, retain) UITableView *subcateTableView;
@property (nonatomic, retain) UITableView *manuTableView;
@property (nonatomic, retain) NSMutableArray *subIdAndNameArray, *manuArray, *titleArray, *arrayWithTitle;
@property (nonatomic, retain) DataSource *dataSource;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableArray *topArray;
@property (nonatomic, retain) NSIndexPath *recordIndexPath;
@property (nonatomic, retain) MJNIndexView *indexView;

@end
