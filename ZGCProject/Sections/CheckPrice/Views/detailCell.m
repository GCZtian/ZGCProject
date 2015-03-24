//
//  detailCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "detailCell.h"
#import "DetailList.h"

#define NAMELABELWIDTH 375
#define NAMELABELHEIGTH 40
#define BRIEFLABELWIDTH [UIScreen mainScreen].bounds.size.width - 10
#define BRIEFLABELHEIGTH 30
#define PRICELABELWIDTH 120
#define PRICELABELHIGTH 30
#define SELLNUMLABELWIDTH 160
#define SELLNUMLABELHIGTH 30
#define SPACE 5
#define SPACEHIGHTH 10

@implementation detailCell

- (void)dealloc
{
    self.nameLabel = nil;
    self.briefLabel = nil;
    self.priceRangeLabel = nil;
    self.sellNumLabel = nil;
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGHTH, NAMELABELWIDTH, NAMELABELHEIGTH)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel release];
        
        self.briefLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGHTH + NAMELABELHEIGTH + 5, BRIEFLABELWIDTH, BRIEFLABELHEIGTH)];
        self.briefLabel.numberOfLines = 0;
        [self.contentView addSubview:_briefLabel];
        [_briefLabel release];
        
        self.priceRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGHTH + NAMELABELHEIGTH + BRIEFLABELHEIGTH + 10, PRICELABELWIDTH, PRICELABELHIGTH)];
        _priceRangeLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceRangeLabel];
        [_priceRangeLabel release];
        
        self.sellNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + PRICELABELWIDTH + 50, SPACEHIGHTH + NAMELABELHEIGTH + BRIEFLABELHEIGTH + 10, SELLNUMLABELWIDTH, SELLNUMLABELHIGTH)];
        [self.contentView addSubview:_sellNumLabel];
        [_sellNumLabel release];
    }
    return self;
}

//重写set方法
-(void)setDetail:(DetailList *)detail
{
    if (_detail != detail) {
        [_detail release];
        _detail = [detail retain];
    }
    _nameLabel.text = _detail.nameString;
    _briefLabel.text = _detail.briefString;
    if (_detail.seriesProNum == nil) {
        _priceRangeLabel.text = _detail.price;
    } else {
        _priceRangeLabel.text = _detail.priceRange;
    }
    _sellNumLabel.text = _detail.sellNum;
    
    //设置字体大小
    if (_nameLabel.text.length != 0) {
        [self settingTheWords:_nameLabel];
        [self settingTheWords:_sellNumLabel];
    }
    //调用方法
    [self resetLabelFrame:_nameLabel.text labelWithName:_nameLabel font:18];
    [self resetLabelFrame:_briefLabel.text labelWithName:_briefLabel font:17];
    
    //重设控件的frame
    [self resetFrames];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//label自适应高度
- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //重新设定lable的frame
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
}

//自适应行高
- (CGFloat)heighOfStrings
{
    return self.sellNumLabel.frame.size.height + self.sellNumLabel.frame.origin.y + 10;
}

//重新设定frame
- (void)resetFrames
{
    CGRect frame = _briefLabel.frame;
    _briefLabel.frame = CGRectMake(frame.origin.x, _nameLabel.frame.size.height + 10, frame.size.width, frame.size.height);
    
    frame = _priceRangeLabel.frame;
    _priceRangeLabel.frame = CGRectMake(frame.origin.x, _nameLabel.frame.size.height + 15 + _briefLabel.frame.size.height, frame.size.width, frame.size.height);
    
    frame = _sellNumLabel.frame;
    _sellNumLabel.frame = CGRectMake(frame.origin.x, _priceRangeLabel.frame.origin.y, frame.size.width, frame.size.height);
}

- (void)settingTheWords:(UILabel *)label
{
    //在label上设置不同字体大小的文字
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    NSRange range = [label.text rangeOfString:@"("];
    if ([label.text rangeOfString:@"("].length == 0) {
        label.font = [UIFont systemFontOfSize:17];
    } else {
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13] range:NSMakeRange(range.location, label.text.length - range.location)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(range.location, label.text.length - range.location)];
    }
    label.attributedText = str;
}


@end
