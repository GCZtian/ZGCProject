//
//  DetailTableViewCell.h
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailList;
@interface DetailTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *phoneImageView, *arrowsImageView;
@property (nonatomic, retain) UIView *lineView;
@property (nonatomic, retain) UILabel *lookLabel;
@property (nonatomic, retain) DetailList *detailList;
@end
