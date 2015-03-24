    //
    //  CustomTableViewCell.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/7.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "NewsCustomTableViewCell.h"

#define MARGIN 5
#define MAINWIDTH [UIScreen mainScreen].bounds.size.width
#define CELLHIGH 80

@implementation NewsCustomTableViewCell

- (void)dealloc
{
    self.photoView = nil;
    self.titleLabel = nil;
    self.dateLabel = nil;
    self.leftCountLabel = nil;
    self.rightCountLabel = nil;
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, MARGIN, CELLHIGH, CELLHIGH - 10)];
        _photoView.opaque = YES;
        _photoView.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.contentView addSubview:_photoView];
        [_photoView release];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLHIGH + 10, MARGIN, MAINWIDTH - CELLHIGH - 10, 40)];
        _titleLabel.opaque = YES;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLHIGH + 10, CELLHIGH - 20, MAINWIDTH / 3, 20)];
        _dateLabel.opaque = YES;
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        self.leftCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINWIDTH / 3 * 2, CELLHIGH - 20, CELLHIGH - 20, 20)];
        _leftCountLabel.opaque = YES;
        _leftCountLabel.textAlignment = NSTextAlignmentLeft;
        _leftCountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_leftCountLabel];
        [_leftCountLabel release];
        
        self.rightCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINWIDTH - CELLHIGH + MARGIN, CELLHIGH - 20, CELLHIGH - 20, 20)];
        _rightCountLabel.opaque = YES;
        _rightCountLabel.textAlignment = NSTextAlignmentCenter;
        _rightCountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_rightCountLabel];
        [_rightCountLabel release];
        
    }
    return self;
}

    //重置title Label 的frame
- (void)resetLabelFrame:(NSString *)aString
{
        //计算文本的高度
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(MAINWIDTH - CELLHIGH, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    _titleLabel.frame = CGRectMake(CELLHIGH + 10, MARGIN, MAINWIDTH - CELLHIGH - 10, rect.size.height);
}

- (void)resetTypeFrame:(NSString *)aString
{
        //计算文本的宽度
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(0, MARGIN) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    _rightCountLabel.frame = CGRectMake(MAINWIDTH - rect.size.width - 20, _rightCountLabel.frame.origin.y, rect.size.width, _rightCountLabel.frame.size.height);
}

//    //重设lable的高度
//+ (CGFloat)heightCharStirng:(NSString *)aString
//{
//        //计算文本的宽度
//    CGRect rect = [aString boundingRectWithSize:CGSizeMake(0, MARGIN) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
//    
//    
//    
//    
//}


- (void)awakeFromNib {
        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
}

@end
