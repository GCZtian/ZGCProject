//
//  SearchViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@interface SearchViewController : UIViewController

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSMutableArray *arrayName;
@property (nonatomic, retain) UITableView *selfTabelView;
@property (nonatomic, retain) UILabel *resultLabel;
@property (nonatomic, retain) DataSource *dataSource;

@end
