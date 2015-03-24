//
//  DetailViewController.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class MakeOffersView;
@class EvaluatingTableView;
@interface DetailViewController : UIViewController

@property (nonatomic, retain) NSString *seriesId;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSMutableArray *detailArray;
@property (nonatomic, retain) UITableView *detaiView;
@property (nonatomic, retain) NSMutableArray *detailProArray;
@property (nonatomic, retain) NSString *proId;
@property (nonatomic, retain) NSMutableArray *extraArray;
@property (nonatomic, retain) NSMutableArray *nameArray;
@property (nonatomic, retain) MakeOffersView *makeOffers;
@property (nonatomic, retain) NSString *Id;
@property (nonatomic, retain) EvaluatingTableView *evaluating;
@property (nonatomic, retain) UISegmentedControl *segement;
@property (nonatomic, retain) NSMutableArray *titleArray;

@end
