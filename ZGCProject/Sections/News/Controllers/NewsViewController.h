//
//  NewsViewController.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class NewaDataHandle;
@class DetailTableView;

@interface NewsViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *mArrayPicture;
@property (nonatomic, retain) DataSource *dataSource;
@property (nonatomic, retain) NewaDataHandle *netDataSoure;
@property (nonatomic, retain) DetailTableView *detailTableView;
@property (nonatomic, retain) NSMutableDictionary *dataDic;
@property (nonatomic, assign) NSString *idCount;

@property (nonatomic, retain) NSMutableArray *navigationTotle;//存放navigation对象
@property (nonatomic, retain) NSMutableArray *navigationIDArray;//存放ID
@property (nonatomic, retain) NSMutableArray *navigationNameArray;//存放name

@end
