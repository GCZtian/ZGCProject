//
//  DetailedParametersTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetailedParametersTableViewCell.h"
#import "Detal.h"

#define NAMELAELWIDTH 100
#define NAMELAELHIGTH 30
#define SYMBOLWIDTH 30

@implementation DetailedParametersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, NAMELAELWIDTH, NAMELAELHIGTH)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.numberOfLines = 0;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.symbolLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAMELAELWIDTH + 5, 5, SYMBOLWIDTH, SYMBOLWIDTH)];
        _symbolLabel.text = @":";
        [self.contentView addSubview:_symbolLabel];
        [_symbolLabel release];
        
        self.detailLael = [[UILabel alloc] initWithFrame:CGRectMake(10 + NAMELAELWIDTH + 15, 5, [UIScreen mainScreen].bounds.size.width - 25 - NAMELAELWIDTH, 30)];
        _detailLael.numberOfLines = 0;
        _detailLael.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_detailLael];
        [_detailLael release];
    }
    return self;
}

- (void)setDetail:(Detal *)detail
{
    if (_detail != detail) {
        [_detail release];
        _detail = [detail retain];
    }
    _detailLael.text = _detail.value;
    _nameLabel.text = _detail.name;
    [self resetLabelFrame:_detailLael.text labelWithName:_detailLael font:14];
    [self resetLabelFrame:_nameLabel.text labelWithName:_nameLabel font:14];
    
    CGPoint center = self.nameLabel.center;
    if (_nameLabel.frame.size.height > _detailLael.frame.size.height) {
        _detailLael.center = CGPointMake(_detailLael.center.x, center.y);
        _symbolLabel.center = CGPointMake(_symbolLabel.center.x, center.y);
    } else {
    _nameLabel.center = CGPointMake(center.x, _detailLael.center.y);
    _symbolLabel.center = CGPointMake(_symbolLabel.center.x, _nameLabel.center.y);
    }
}




- (CGFloat)heighOfStrings
{
    if (_nameLabel.frame.size.height > _detailLael.frame.size.height) {
        return  _nameLabel.frame.size.height + 10;
    } else {
    return _detailLael.frame.size.height + 10;
    }
}

- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //重新设定lable的frame
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
