//
//  OfferTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "OfferTableViewCell.h"
#import "ExtraProsDataSource.h"
#import "TableViewController.h"

#define NAMELABELWIDTH [UIScreen mainScreen].bounds.size.width
#define NAMELABELHIGHT 40
#define DETAILEDWIDTH 80
#define DETAILEDHIGTH 30
#define SPACE 5
#define SPACEHIGTH 0

@implementation OfferTableViewCell

- (void)dealloc
{
    self.nameLabel = nil;
    self.detailedParametersButton = nil;
    self.extraPros = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGTH, NAMELABELWIDTH, NAMELABELHIGHT)];
        _nameLabel.textColor = [UIColor greenColor];
        _nameLabel.numberOfLines = 2;
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.detailedParametersButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.detailedParametersButton.frame = CGRectMake(SPACE + 10, SPACEHIGTH + NAMELABELHIGHT + 5, DETAILEDWIDTH, DETAILEDHIGTH);
        _detailedParametersButton.layer.borderWidth = 0.5;
        [_detailedParametersButton setTitle:@"详细参数" forState:UIControlStateNormal];
        [self.contentView addSubview:_detailedParametersButton];
        
    }
    return self;
}


- (void)setExtraPros:(ExtraProsDataSource *)extraPros
{
    if (_extraPros != extraPros) {
        [_extraPros release];
        _extraPros = [extraPros retain];
    }
    
    _nameLabel.text = _extraPros.name;
    [self resetLabelFrame:_nameLabel.text labelWithName:_nameLabel font:18];
//    [self resetFrames];
}

- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //重新设定lable的frame
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
}

- (CGFloat)heighOfStrings
{
    return _detailedParametersButton.frame.origin.y + _detailedParametersButton.frame.size.height + 5;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
