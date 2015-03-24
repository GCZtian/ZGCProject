//
//  SearchPostCell.h
//  ZGCProject
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResultData;

@interface SearchPostCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *bbs_nameLabel;
@property (nonatomic, retain) UILabel *replyLabel;
@property (nonatomic, retain) UILabel *hitsLabel;
@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) SearchResultData *searchRD;

+ (CGFloat)heightOfCell:(NSString *)string;

@end
