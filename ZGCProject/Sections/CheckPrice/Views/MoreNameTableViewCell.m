//
//  MoreNameTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "MoreNameTableViewCell.h"
#import "ExtraProsDataSource.h"

#define PRICENAMELABELWIDTH 250
#define PRICENAMELABELHIGTH 40
#define PRICELABELWIDTH [UIScreen mainScreen].bounds.size.width - PRICENAMELABELWIDTH - SPACE - 5
#define PRICELABELHIGTH 40
#define SPACE 5
#define SPACEHIGTH 0

@implementation MoreNameTableViewCell

- (void)dealloc
{
    self.priceLabel = nil;
    self.priceNameLabel = nil;
    self.extraPros = nil;
    [super dealloc];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.priceNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGTH, PRICENAMELABELWIDTH, PRICENAMELABELHIGTH)];
        _priceNameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_priceNameLabel];
        [_priceNameLabel release];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + PRICENAMELABELWIDTH, SPACEHIGTH, PRICELABELWIDTH, PRICELABELHIGTH)];
        _priceLabel.font = [UIFont boldSystemFontOfSize:17];
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel release];
    }
    return self;
}

- (void)setExtraPros:(ExtraProsDataSource *)extraPros
{
    if (_extraPros != extraPros) {
        [_extraPros release];
        _extraPros = [extraPros retain];
    }
    _priceLabel.text = _extraPros.price;
    _priceNameLabel.text = _extraPros.priceName;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
