//
//  SubcateTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "SubcateTableViewCell.h"

@implementation SubcateTableViewCell

- (void)dealloc
{
    self.mainLabel = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 3, 70 + 0.5)];
        _mainLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        _mainLabel.textAlignment = NSTextAlignmentCenter;
        self.mainLabel.textColor = [UIColor blackColor];
        [self addSubview:_mainLabel];
        [_mainLabel release];
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
