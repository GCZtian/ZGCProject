//
//  DetaiParameterTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetaiParSource;
@interface DetaiParameterTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *netLabel;
@property (nonatomic, retain) UILabel *symbolLabel;
@property (nonatomic, retain) UILabel *parameterLabel;
@property (nonatomic, retain) DetaiParSource *detailPar;

- (CGFloat)heighOfStrings;
@end
