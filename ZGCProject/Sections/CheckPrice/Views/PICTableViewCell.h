//
//  PICTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Evaluating;
@interface PICTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *imageViewOne;
@property (nonatomic, retain) UIImageView *imageViewTwo;
@property (nonatomic, retain) UIImageView *imageVIewThree;
@property (nonatomic, retain) UILabel *picTitle;
@property (nonatomic, retain) Evaluating *eval;

@end
