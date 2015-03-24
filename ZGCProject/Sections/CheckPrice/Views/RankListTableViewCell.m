//
//  RankListTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "RankListTableViewCell.h"
#define IMAGEHIGTH 40
#define IMAGEWIGHTH 80
#define DISTANCE 10
#define SPACE 10

@implementation RankListTableViewCell

- (void)dealloc
{
    self.label = nil;
    self.imageName = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageName = [[UIImageView alloc] initWithFrame:CGRectMake(DISTANCE, SPACE, IMAGEWIGHTH, IMAGEHIGTH)];
        [self addSubview:_imageName];
        [_imageName release];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(DISTANCE + IMAGEWIGHTH + 20, DISTANCE, 150, 50)];
        _label.font = [UIFont systemFontOfSize:15];
        [self addSubview:_label];
        [_label release];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
