//
//  CustomTableViewCell.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCustomTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *leftCountLabel;//评论个数label
@property (nonatomic, retain) UILabel *rightCountLabel;//图片个数label


//    //重设lable的高度
//+ (CGFloat)heightCharStirng:(NSString *)aString;
    //重置title Label 的frame
- (void)resetLabelFrame:(NSString *)aString;
    //重置直播,视图,的frame
- (void)resetTypeFrame:(NSString *)aString;

@end
