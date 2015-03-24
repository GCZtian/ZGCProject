//
//  detailCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailList;
@interface detailCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *briefLabel;
@property (nonatomic, retain) UILabel *priceRangeLabel;
@property (nonatomic, retain) UILabel *sellNumLabel;
@property (nonatomic, retain) DetailList *detail;

- (CGFloat)heighOfStrings;
@end
