//
//  EvaluatingTableView.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataSource;
@class DetailViewController;
@interface EvaluatingTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSString *proID;
@property (nonatomic, retain) NSString *seriesId;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSMutableArray *picSrcArray;
@property (nonatomic, retain) NSMutableArray *commenArray;
@property (nonatomic, retain) NSMutableArray *titileArray;
@property (nonatomic, retain) DetailViewController *detial;
@property (nonatomic, retain) NSString *url;

@end
