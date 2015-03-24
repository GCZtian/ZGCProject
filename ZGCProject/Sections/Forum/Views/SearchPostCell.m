//
//  SearchPostCell.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "SearchPostCell.h"

#import "SearchResultData.h"

#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define SPACE 10
#define TITLEH 40
#define ALPHL 0.5

@implementation SearchPostCell

- (void)dealloc
{
    self.titleLabel = nil;
    self.bbs_nameLabel = nil;
    self.replyLabel = nil;
    self.hitsLabel = nil;
    self.backView = nil;
    self.searchRD = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //背景
        self.backgroundColor = [UIColor colorWithWhite:0.812 alpha:1.0];
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
        self.backView.layer.cornerRadius = 5;
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = _backView;
        [_backView release];
        
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, 2, WIDTH - SPACE * 4, 30)];
        self.titleLabel.numberOfLines = 0;
        [_backView addSubview:_titleLabel];
        [_titleLabel release];
        
        //bbs
        self.bbs_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE, TITLEH, 80, 30)];
        self.bbs_nameLabel.font = [UIFont systemFontOfSize:14];
        self.bbs_nameLabel.textColor = [UIColor colorWithWhite:ALPHL alpha:1];
        [_backView addSubview:_bbs_nameLabel];
        [_bbs_nameLabel release];
        
        //回复
        self.replyLabel = [[UILabel alloc] initWithFrame:CGRectMake( WIDTH - 150, TITLEH, 60, 30)];
        self.replyLabel.font = [UIFont systemFontOfSize:15];
        self.replyLabel.textColor = [UIColor colorWithWhite:ALPHL alpha:1.0];
        [_backView addSubview:_replyLabel];
        [_replyLabel release];
        
        //浏览
        self.hitsLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 90, TITLEH, 90, 30)];
        self.hitsLabel.font = [UIFont systemFontOfSize:15];
        self.hitsLabel.textColor = [UIColor colorWithWhite:ALPHL alpha:1.0];
        [_backView addSubview:_hitsLabel];
        [_hitsLabel release];
    }
    return self;
}

//重写setter重新布局
- (void)setSearchRD:(SearchResultData *)searchRD
{
    if (_searchRD != searchRD) {
        [_searchRD release];
        _searchRD = [searchRD retain];
    }
    
    self.titleLabel.text = searchRD.title;
    self.bbs_nameLabel.text = searchRD.bbs;
    self.replyLabel.text = [NSString stringWithFormat:@"%@ 回", searchRD.reply];
    self.hitsLabel.text = [NSString stringWithFormat:@"%@ 浏览", searchRD.hits];
    CGRect rect = [self.titleLabel.text boundingRectWithSize:CGSizeMake(WIDTH - SPACE * 4, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    self.titleLabel.frame = CGRectMake(SPACE, 10, WIDTH - SPACE * 4, rect.size.height);
    self.bbs_nameLabel.frame = CGRectMake(SPACE, 15 + rect.size.height, 80, 30);
    self.replyLabel.frame = CGRectMake( WIDTH - 150, 15 + rect.size.height, 60, 30);
    self.hitsLabel.frame = CGRectMake(WIDTH - 90, 15 + rect.size.height, 90, 30);
    self.backView.frame = CGRectMake(0, 5, WIDTH, rect.size.height + 45);
}

//返回行高
+ (CGFloat)heightOfCell:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(WIDTH - SPACE * 4, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height + 45;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
