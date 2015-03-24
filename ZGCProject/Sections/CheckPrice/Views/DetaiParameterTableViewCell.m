//
//  DetaiParameterTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetaiParameterTableViewCell.h"
#import "DetaiParSource.h"

#define NETLABELWIDTH 100
#define NETLABELHEIGTH 30
#define SYMBOLLABELWIDTH 40
#define SYMBOLLABELHEIGTH 30
#define PARAMETERLABELWIDTH [UIScreen mainScreen].bounds.size.width - NETLABELWIDTH - SPACE - 40
#define PARAMETERLABELHEIGTH 30
#define SPACE 5
#define SPACEHEIGTH 10

@implementation DetaiParameterTableViewCell

- (void)dealloc
{
    self.parameterLabel = nil;
    self.symbolLabel = nil;
    self.netLabel = nil;
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.netLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, SPACEHEIGTH, NETLABELWIDTH, NETLABELHEIGTH)];
        _netLabel.numberOfLines = 0;
        [self.contentView addSubview:_netLabel];
        [_netLabel release];
        
        self.symbolLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE +  NETLABELWIDTH, SPACEHEIGTH, SYMBOLLABELWIDTH, SYMBOLLABELHEIGTH)];
        _symbolLabel.text = @":";
        [self.contentView addSubview:_symbolLabel];
        [_symbolLabel release];
        self.parameterLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + NETLABELWIDTH + SYMBOLLABELWIDTH, SPACEHEIGTH, PARAMETERLABELWIDTH, PARAMETERLABELHEIGTH)];
        _parameterLabel.font = [UIFont systemFontOfSize:15];
        _parameterLabel.numberOfLines = 0;
        [self.contentView addSubview:_parameterLabel];
        [_parameterLabel release];
    }
    return self;
}

//重写set方法
-(void)setDetailPar:(DetaiParSource *)detailPar
{
    if (_detailPar != detailPar) {
        [_detailPar release];
        _detailPar = [detailPar retain];
    }
    _netLabel.text = _detailPar.name;
    _parameterLabel.text = _detailPar.value;
    
    [self resetLabelFrame:_netLabel.text labelWithName:_netLabel font:17];
    [self resetLabelFrame:_parameterLabel.text labelWithName:_parameterLabel font:15];
    
    
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
    return self.parameterLabel.frame.size.height + self.parameterLabel.frame.origin.y + 10;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
