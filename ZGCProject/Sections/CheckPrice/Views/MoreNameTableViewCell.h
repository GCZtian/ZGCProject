//
//  MoreNameTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExtraProsDataSource;
@interface MoreNameTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *priceNameLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) ExtraProsDataSource *extraPros;

@end
