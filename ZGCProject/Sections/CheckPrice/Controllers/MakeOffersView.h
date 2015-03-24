//
//  MakeOffersView.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@interface MakeOffersView : UITableView<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property (nonatomic, retain) NSMutableArray *sectionArray;
@property (nonatomic, retain) NSMutableArray *titleNameArray;
@property (nonatomic, retain) DetailViewController *detai;

@end
    
