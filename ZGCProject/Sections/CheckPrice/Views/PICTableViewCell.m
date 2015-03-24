//
//  PICTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "PICTableViewCell.h"
#import "Evaluating.h"

#define PICTITLEWIDTH 350
#define PICTITLEHIGTH 30
#define IMAGEWIDTH 108
#define IMAGEHIGTH 70
#define SPACE 10
#define SPACEHIGTH 5

@implementation PICTableViewCell

- (void)dealloc
{
    self.imageViewOne = nil;
    self.imageViewTwo = nil;
    self.imageVIewThree = nil;
    self.picTitle = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGTH + PICTITLEHIGTH, IMAGEWIDTH, IMAGEHIGTH)];
        [self addSubview:_imageViewOne];
        [_imageViewOne release];
        
        self.imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE + IMAGEWIDTH + SPACE, SPACEHIGTH + PICTITLEHIGTH, IMAGEWIDTH, IMAGEHIGTH)];
        [self addSubview:_imageViewTwo];
        [_imageViewTwo release];
        
        self.imageVIewThree = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE + IMAGEWIDTH + SPACE + IMAGEWIDTH + SPACE, SPACEHIGTH + PICTITLEHIGTH, IMAGEWIDTH, IMAGEHIGTH)];
        [self addSubview:_imageVIewThree];
        [_imageVIewThree release];

        self.picTitle = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGTH, PICTITLEWIDTH, PICTITLEHIGTH)];
        [self.contentView addSubview:_picTitle];
        [_picTitle release];
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
