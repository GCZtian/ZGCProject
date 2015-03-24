//
//  OfferTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ExtraProsDataSource;
@interface OfferTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *detailedParametersButton;
@property (nonatomic, retain) ExtraProsDataSource *extraPros;

- (CGFloat)heighOfStrings;

@end
