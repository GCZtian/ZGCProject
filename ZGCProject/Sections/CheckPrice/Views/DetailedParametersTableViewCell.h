//
//  DetailedParametersTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Detal;
@interface DetailedParametersTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *symbolLabel;
@property (nonatomic, retain) UILabel *detailLael;
@property (nonatomic, retain) Detal *detail;


- (CGFloat)heighOfStrings;
@end
