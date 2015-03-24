//
//  AllPhoneTableViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@interface AllPhoneTableViewController : UITableViewController

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *subId;
@property (nonatomic, retain) NSString *allNumber;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSMutableArray *allPhoneArray;
@property (nonatomic, assign) int i;
@end
