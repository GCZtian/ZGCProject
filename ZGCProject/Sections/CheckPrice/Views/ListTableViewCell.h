//
//  CustomTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListSource;
@interface ListTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *priceLabel, *comment;
@property (nonatomic, retain) UIImageView *image, *imaged;
@property (nonatomic, retain) UIView *starView;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) UILabel *attentionLabel;
@property (nonatomic, retain) ListSource *listSource;
@property (nonatomic, retain) UIImageView *awardImage;

//返回cell的高度
- (CGFloat)heighOfString;
- (void)setListSource:(ListSource *)listSource;
//重新设定Label的高度
- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size;

@end
