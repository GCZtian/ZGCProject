//
//  BBSTableView.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class DetailViewController;

@interface BBSTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) DataSource *myData;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) DetailViewController *detail;
@property (nonatomic, retain) NSString *productid;

@end
