//
//  SearchViewController.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;

@interface NewsSearchViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) DataSource *dataSource;

@end
