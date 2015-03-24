//
//  BBSTableViewCell.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *handPhoto;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *authorName;
@property (nonatomic, retain) UILabel *data;
@property (nonatomic, retain) UILabel *comCount;

    //自适应行高
- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label;


@end
