//
//  TableViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@interface TableViewController : UITableViewController

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *proId;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSString *seriesId;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) NSMutableArray *detailArray;

@end
