//
//  EvaluatingTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@interface EvaluatingTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *picImageView;
@property (nonatomic, retain) UILabel *reviewNumLabel;
@property (nonatomic, retain) UILabel *dataLabel;
@property (nonatomic, retain) News *news;

- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size;
@end
