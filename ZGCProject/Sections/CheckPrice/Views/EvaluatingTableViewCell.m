//
//  EvaluatingTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "EvaluatingTableViewCell.h"
#import "News.h"
#import "UIImageView+WebCache.h"
#define PICWIDTH 90
#define PICHIGTH 60
#define TITLELABELWIDTH [UIScreen mainScreen].bounds.size.width - SPACE - PICWIDTH - 5
#define TITLELABELHIGTH 35
#define SPACE 10
#define SPACEHIGTH 10

@implementation EvaluatingTableViewCell

- (void)dealloc
{
    self.titleLabel = nil;
    self.picImageView = nil;
    self.reviewNumLabel = nil;
    self.dataLabel = nil;
    self.news = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + PICWIDTH + 10, SPACEHIGTH, TITLELABELWIDTH, TITLELABELHIGTH)];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE, SPACEHIGTH, PICWIDTH, PICHIGTH)];
        [self.contentView addSubview:_picImageView];
        [_picImageView release];
        
        self.reviewNumLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 65, self.picImageView.frame.size.height - 10, 60, 20)];
        _reviewNumLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_reviewNumLabel];
        [_reviewNumLabel release];
        
        self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + PICWIDTH + 10, self.picImageView.frame.size.height - 10, 100, 20)];
        _dataLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dataLabel];
        [_dataLabel release];
    }
    return self;
}

- (void)setNews:(News *)news
{
    if (_news != news) {
        [_news release];
        _news = [news retain];
    }
    _dataLabel.text = [_news.date substringToIndex:10];
    _reviewNumLabel.text = _news.reviewNum;
    _titleLabel.text = _news.title;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:_news.picString]];
    [self resetLabelFrame:_titleLabel.text labelWithName:_titleLabel font:17];
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
