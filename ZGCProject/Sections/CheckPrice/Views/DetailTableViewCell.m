//
//  DetailTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "DetailList.h"
#import "UIImageView+WebCache.h"


#define IMAGESIZEOFWIDTH [UIScreen mainScreen].bounds.size.width - 2 * SPACEWIDTH
#define IMAGESIZEOFHIGTH 170
#define SPACEWIDTH 60
#define SPACEHIGTH 10
@implementation DetailTableViewCell

- (void)dealloc
{
    self.phoneImageView = nil;
    self.detailList = nil;
    self.lineView = nil;
    self.lookLabel = nil;
    self.arrowsImageView = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SPACEWIDTH, SPACEHIGTH, IMAGESIZEOFWIDTH, IMAGESIZEOFHIGTH)];
        [self.contentView addSubview:_phoneImageView];
        [_phoneImageView release];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, SPACEHIGTH + IMAGESIZEOFHIGTH + 10, [UIScreen mainScreen].bounds.size.width, 1)];
        _lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self.contentView addSubview:_lineView];
        [_lineView release];
        
        self.lookLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SPACEHIGTH + IMAGESIZEOFHIGTH + 11, [UIScreen mainScreen].bounds.size.width, 30)];
        _lookLabel.layer.borderWidth = 0.2;
        _lookLabel.textAlignment = NSTextAlignmentCenter;
        _lookLabel.textColor = [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0];
        [self.contentView addSubview:_lookLabel];
        [_lookLabel release];
        
        self.arrowsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(270, 0, 30, 30)];
        _arrowsImageView.image = [UIImage imageNamed:@"Details-description-expend"];
        [_lookLabel addSubview:_arrowsImageView];
        [_arrowsImageView release];
        
    }
    return self;
}

- (void)setDetailList:(DetailList *)detailList
{
    if (_detailList != detailList) {
        [_detailList release];
        _detailList = [detailList retain];
    }
    [self.phoneImageView sd_setImageWithURL:[NSURL URLWithString:_detailList.imageString]];
    if ([_detailList.imageString isEqualToString:@""]) {
        _lookLabel.text = @"暂无图片";
    } else {
        _lookLabel.text = [NSString stringWithFormat:@"查看更多图片(%d)", [_detailList.picNumber intValue]];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
