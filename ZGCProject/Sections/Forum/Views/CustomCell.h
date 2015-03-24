//
//  CustomCell.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostCellData;
@class HandpickCellData;
@class StypeCellData;

@interface CustomCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *goodIV;
@property (nonatomic, retain) UIImageView *contentIV1;
@property (nonatomic, retain) UIImageView *contentIV2;
@property (nonatomic, retain) UIImageView *contentIV3;
@property (nonatomic, retain) UIImageView *logoIV;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *replyLabel;
@property (nonatomic, retain) UILabel *lastDateLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *stypeLabel;
@property (nonatomic, retain) UILabel *clickGoodLabel;
@property (nonatomic, retain) UIImageView *clickGoodIV;
@property (nonatomic, retain) PostCellData *postCellData;
@property (nonatomic, retain) HandpickCellData *handpickCellData;
@property (nonatomic, retain) StypeCellData *stypeCellData;

+ (CGFloat)heightOfRotPostWithString:(NSString *)string;
+ (CGFloat)heightOfModulePostWithString:(NSString *)string;

@end
