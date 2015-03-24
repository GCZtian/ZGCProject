//
//  VidioViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class PostViewController;
@interface VidioViewController : UIViewController

@property (nonatomic, retain) UITableView *VCRView;
@property (nonatomic, retain) NSString *proid;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) PostViewController *posting;
@property (nonatomic, retain) NSMutableArray *titleArray;
@property (nonatomic, retain) NSMutableArray *commentArray;

@end
