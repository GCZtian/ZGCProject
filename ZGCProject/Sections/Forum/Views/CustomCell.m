//
//  CustomCell.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "CustomCell.h"

#import "PostCellData.h"
#import "UIImageView+WebCache.h"
#import "HandpickCellData.h"
#import "StypeCellData.h"


#define MARGIN 5
#define IMAGESIZE 70
#define LABEL 22
#define IMAGEWIDTH ([UIScreen mainScreen].bounds.size.width - 4 * MARGIN) / 3

@interface CustomCell()
{
    NSDate *fixationDate;
}

@end

@implementation CustomCell

#pragma mark - 自带cell方法

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - 重写dealloc

- (void)dealloc
{
    self.titleLabel = nil;
    self.goodIV = nil;
    self.contentIV1 = nil;
    self.contentIV2 = nil;
    self.contentIV3 = nil;
    self.logoIV = nil;
    self.authorLabel = nil;
    self.replyLabel = nil;
    self.lastDateLabel = nil;
    self.dateLabel = nil;
    self.stypeLabel = nil;
    self.clickGoodLabel = nil;
    self.clickGoodIV = nil;
    self.postCellData = nil;
    self.handpickCellData = nil;
    self.stypeCellData = nil;
    [super dealloc];
}

#pragma mark - 自定义cell初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.opaque = YES;
        //标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2 + LABEL, MARGIN, [UIScreen mainScreen].bounds.size.width - 3 * MARGIN - LABEL, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 0;
        _titleLabel.opaque = YES;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        //加精(必须保证先加标题再加加精图片,为了显示上层图片)
        self.goodIV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, LABEL - MARGIN / 2, LABEL - MARGIN / 2)];
        _goodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_jingpin"];
        _goodIV.opaque = YES;
        [self.contentView addSubview:_goodIV];
        [_goodIV release];
        
        //如果1楼有图,插图
        self.contentIV1 = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE)];
        _contentIV1.opaque = YES;
        [self.contentView addSubview:_contentIV1];
        [_contentIV1 release];
        
        self.contentIV2 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * MARGIN + IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE)];
        _contentIV2.opaque = YES;
        [self.contentView addSubview:_contentIV2];
        [_contentIV2 release];
        
        self.contentIV3 = [[UIImageView alloc] initWithFrame:CGRectMake(3 * MARGIN + 2 * IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE)];
        _contentIV3.opaque = YES;
        [self.contentView addSubview:_contentIV3];
        [_contentIV3 release];

        
        //设置头像
        self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, 3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, LABEL, LABEL)];
        _logoIV.layer.cornerRadius = LABEL / 2.;
        _logoIV.clipsToBounds = YES;
        _logoIV.opaque = YES;
        [self.contentView addSubview:_logoIV];
        [_logoIV release];
        
        //设置作者label
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2 + LABEL,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 130, LABEL)];
        _authorLabel.opaque = YES;
//        _authorLabel.adjustsFontSizeToFitWidth = YES;
        _authorLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_authorLabel];
        [_authorLabel release];
        
        //设置回帖label
        self.replyLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 165 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 50, LABEL)];
        _replyLabel.opaque = YES;
        _replyLabel.textAlignment = NSTextAlignmentRight;
        _replyLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_replyLabel];
        [_replyLabel release];
        
        //设置最后更新时间label
        self.lastDateLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 115 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 100, LABEL)];
        _lastDateLabel.opaque = YES;
        _lastDateLabel.textAlignment = NSTextAlignmentRight;
        _lastDateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lastDateLabel];
        [_lastDateLabel release];
        
        //设置发帖日期label
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 100, LABEL)];
        _dateLabel.adjustsFontSizeToFitWidth = YES;
        _dateLabel.opaque = YES;
        _dateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        //设置论坛分类label
        self.stypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2 + _dateLabel.frame.size.width, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL)];
        _stypeLabel.opaque = YES;
        _stypeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_stypeLabel];
        [_stypeLabel release];
        
        //设置点赞个数:
        self.clickGoodLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL)];
        _clickGoodLabel.opaque = YES;
        _clickGoodLabel.textAlignment = NSTextAlignmentCenter;
        _clickGoodLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_clickGoodLabel];
        [_clickGoodLabel release];
        
        //这是点赞图片:
        self.clickGoodIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_forum_hotpost_zannormal"]];
        _clickGoodIV.opaque = YES;
        _clickGoodIV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL);
        [self.contentView addSubview:_clickGoodIV];
        [_clickGoodIV release];
        
        //打开交互
        _clickGoodIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sayGood)];
        [_clickGoodIV addGestureRecognizer:tapGR];
        [tapGR release];
        
    }
    return self;
}

#pragma mark - 自适应高度计算标题frame

- (void)getTitleFrameOfString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * MARGIN, 0) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    _titleLabel.frame = CGRectMake(MARGIN, MARGIN, [UIScreen mainScreen].bounds.size.width - 2 * MARGIN, rect.size.height);
}

#pragma mark - 点赞触发事件

- (void)sayGood
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点赞 + 1" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    int number = [_clickGoodLabel.text intValue] + 1;
    if (number == 1) {
        _clickGoodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zannormal"];
        _clickGoodLabel.hidden = NO;
    }
    _clickGoodLabel.text = [NSString stringWithFormat:@"%d", number];
}

#pragma mark - 插图图片加载方法

- (void)loadImageWithArray:(NSArray *)array
{
    switch (array.count) {
        case 1:
        {
            NSURL *url1 = [NSURL URLWithString:array[0]];
            
            //用用管理block下载图片
            //            [self.contentIV1 sd_setImageWithPreviousCachedImageWithURL:url1 andPlaceholderImage:[UIImage imageNamed:@"depress"] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //                NSLog(@"%lu +++++----- %lu", receivedSize, expectedSize);
            //            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //                blockSelf.contentIV1.image = image;
            //            }];
            [self.contentIV1 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"depress"]];
            _contentIV1.hidden = NO;
            _contentIV2.hidden = YES;
            _contentIV3.hidden = YES;
            break;
        }
        case 2:
        {
            NSURL *url1 = [NSURL URLWithString:array[0]];
            [self.contentIV1 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"depress"]];
            
            NSURL *url2 = [NSURL URLWithString:array[1]];
            [self.contentIV2 sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"depress"]];
            _contentIV1.hidden = NO;
            _contentIV2.hidden = NO;
            _contentIV3.hidden = YES;
            break;
        }
        case 3:
        {
            NSURL *url1 = [NSURL URLWithString:array[0]];
            [self.contentIV1 sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"depress"]];
            
            NSURL *url2 = [NSURL URLWithString:array[1]];
            [self.contentIV2 sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"depress"]];
            
            NSURL *url3 = [NSURL URLWithString:array[2]];
            [self.contentIV3 sd_setImageWithURL:url3 placeholderImage:[UIImage imageNamed:@"depress"]];
            _contentIV1.hidden = NO;
            _contentIV2.hidden = NO;
            _contentIV3.hidden = NO;
            break;
        }
        default:
            break;
    }
}

#pragma mark - 热帖cell布局

//有插图时的页面布局
- (void)picWithHeightOfCell
{
    _contentIV1.frame = CGRectMake(MARGIN, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _contentIV2.frame = CGRectMake(2 * MARGIN + IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _contentIV3.frame = CGRectMake(3 * MARGIN + 2 * IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _logoIV.frame = CGRectMake(MARGIN, 3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, LABEL, LABEL);
    _authorLabel.frame = CGRectMake(MARGIN * 2 + LABEL,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 130, LABEL);
    _replyLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 165 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 50, LABEL);
    _lastDateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 115 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 100, LABEL);
    _dateLabel.frame = CGRectMake(MARGIN, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 100, LABEL);
    _stypeLabel.frame = CGRectMake(MARGIN * 2 + _dateLabel.frame.size.width, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    _clickGoodLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    _clickGoodIV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 4 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  _titleLabel.frame.size.height + 5 * MARGIN + LABEL * 2 + IMAGESIZE);
}

+ (CGFloat)heightOfRotPostWithString:(NSString *)string
{
    return 0;
}
+ (CGFloat)heightOfModulePostWithString:(NSString *)string
{
    return 0;
}

//无插图时的页面布局
- (void)heightOfCell
{
    _logoIV.frame = CGRectMake(MARGIN, 2 * MARGIN + _titleLabel.frame.size.height, LABEL, LABEL);
    _authorLabel.frame = CGRectMake(MARGIN * 2 + LABEL,  2 * MARGIN + _titleLabel.frame.size.height, 130, LABEL);
    _replyLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 165 - MARGIN,  2 * MARGIN + _titleLabel.frame.size.height, 50, LABEL);
    _lastDateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 115 - MARGIN,  2 * MARGIN + _titleLabel.frame.size.height, 100, LABEL);
    _dateLabel.frame = CGRectMake(MARGIN, 3 * MARGIN + _titleLabel.frame.size.height + LABEL, 100, LABEL);
    _stypeLabel.frame = CGRectMake(MARGIN * 2 + _dateLabel.frame.size.width, 3 * MARGIN + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    _clickGoodLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 3 * MARGIN + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    _clickGoodIV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - MARGIN - 100, 3 * MARGIN + _titleLabel.frame.size.height + LABEL, 80, LABEL);
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  _titleLabel.frame.size.height + 4 * MARGIN + LABEL * 2);
    _contentIV1.hidden = YES;
    _contentIV2.hidden = YES;
    _contentIV3.hidden = YES;
}

#pragma mark - 热帖cell样式

//重写setter方法,进行设置
- (void)setPostCellData:(PostCellData *)postCellData
{
    if (_postCellData != postCellData) {
        [_postCellData release];
        _postCellData = [postCellData retain];
    }
    //是否加精或置顶:
    if ([postCellData.toptype intValue] == 3) {
        _goodIV.hidden = NO;
        self.goodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zhiding"];
        NSString *string = [NSString stringWithFormat:@"精 %@", postCellData.title];
        //标题:
        _titleLabel.text = string;
        [self getTitleFrameOfString:_titleLabel.text];
    } else {
        if ([postCellData.good intValue] == 0) {
            _goodIV.hidden = YES;
            //标题:
            _titleLabel.text = postCellData.title;
            [self getTitleFrameOfString:_titleLabel.text];
        } else {
            _goodIV.hidden = NO;
            NSString *titleString = [NSString stringWithFormat:@"精 %@", postCellData.title];
            //标题:
            _titleLabel.text = titleString;
             [self getTitleFrameOfString:_titleLabel.text];
        }
    }
    
    //插图:判断图片数组元素个数,根据个数显示图片
    [self loadImageWithArray:postCellData.pic_url];
    
    if ([[postCellData.pic_url firstObject] isEqualToString:@""]) {
        [self heightOfCell];
    } else {
        [self picWithHeightOfCell];
    }
    //作者头像
    NSURL *logoURL = [NSURL URLWithString:postCellData.logo];
    [self.logoIV sd_setImageWithURL:logoURL placeholderImage:[UIImage imageNamed:@"smile"]];
    //作者:
    _authorLabel.text = postCellData.author;
    //回帖数及最后更新时间
    _replyLabel.text = postCellData.reply;
    _lastDateLabel.text = postCellData.lastDate;
    //发帖日期
    _dateLabel.text = postCellData.date;
    //论坛名字
    _stypeLabel.text = postCellData.bbsName;
    //点赞数
    _clickGoodLabel.text = [NSString stringWithFormat:@"%@", postCellData.favourNum];
    //判断传进来的点赞参数是否为0;
    if ([postCellData.favourNum intValue] == 0) {
        _clickGoodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zan"];
        _clickGoodLabel.hidden = YES;
    } else {
        _clickGoodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zannormal"];
        _clickGoodLabel.hidden = NO;
    }
}

#pragma mark - 版块页面使用cell布局

//有插图时的页面布局
- (void)picWithHeightOfModuleCell
{
    _contentIV1.frame = CGRectMake(MARGIN, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _contentIV2.frame = CGRectMake(2 * MARGIN + IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _contentIV3.frame = CGRectMake(3 * MARGIN + 2 * IMAGEWIDTH, 2 * MARGIN + _titleLabel.frame.size.height, IMAGEWIDTH, IMAGESIZE);
    _logoIV.frame = CGRectMake(MARGIN, 3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, LABEL, LABEL);
    _authorLabel.frame = CGRectMake(MARGIN * 2 + LABEL,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 130, LABEL);
    _replyLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 165 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 50, LABEL);
    _lastDateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 115 - MARGIN,  3 * MARGIN + IMAGESIZE + _titleLabel.frame.size.height, 100, LABEL);
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  _titleLabel.frame.size.height + 4 * MARGIN + LABEL + IMAGESIZE);
    _dateLabel.hidden = YES;
    _stypeLabel.hidden = YES;
    _clickGoodIV.hidden = YES;
    _clickGoodLabel.hidden = YES;
}

//无插图时的页面布局
- (void)heightOfModuleCell
{
    _logoIV.frame = CGRectMake(MARGIN, 2 * MARGIN + _titleLabel.frame.size.height, LABEL, LABEL);
    _authorLabel.frame = CGRectMake(MARGIN * 2 + LABEL,  2 * MARGIN + _titleLabel.frame.size.height, 130, LABEL);
    _replyLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 165 - MARGIN,  2 * MARGIN + _titleLabel.frame.size.height, 50, LABEL);
    _lastDateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 115 - MARGIN,  2 * MARGIN + _titleLabel.frame.size.height, 100, LABEL);
    self.contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  _titleLabel.frame.size.height + 3 * MARGIN + LABEL);
    _contentIV1.hidden = YES;
    _contentIV2.hidden = YES;
    _contentIV3.hidden = YES;
    _dateLabel.hidden = YES;
    _stypeLabel.hidden = YES;
    _clickGoodIV.hidden = YES;
    _clickGoodLabel.hidden = YES;
}

#pragma mark - 精选cell样式

//重写setter方法,进行设置
- (void)setHandpickCellData:(HandpickCellData *)handpickCellData
{
    if (_handpickCellData != handpickCellData) {
        [_handpickCellData release];
        _handpickCellData = [handpickCellData retain];
    }
    //是否加精或置顶:
    if ([handpickCellData.toptype intValue] == 3) {
        _goodIV.hidden = NO;
        self.goodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zhiding"];
        NSString *string = [NSString stringWithFormat:@"精 %@", handpickCellData.title];
        //标题:
        _titleLabel.text = string;
        [self getTitleFrameOfString:_titleLabel.text];
    } else {
        if ([handpickCellData.good intValue] == 0) {
            _goodIV.hidden = YES;
            //标题:
            _titleLabel.text = handpickCellData.title;
            [self getTitleFrameOfString:_titleLabel.text];
        } else {
            if ([handpickCellData.good intValue] == 1) {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing1"];
            } else if ([handpickCellData.good intValue] == 2) {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing2"];
            } else {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing3"];
            }
            _goodIV.hidden = NO;
            NSString *string = [NSString stringWithFormat:@"精 %@", handpickCellData.title];
            //标题:
            _titleLabel.text = string;
            [self getTitleFrameOfString:_titleLabel.text];
        }
    }
    //插图:判断图片数组元素个数,根据个数显示图片
    [self loadImageWithArray:handpickCellData.pics];
    if (handpickCellData.pics.count == 0) {
        [self heightOfModuleCell];
    } else {
        [self picWithHeightOfModuleCell];
    }
    //作者头像
    NSURL *logoURL = [NSURL URLWithString:handpickCellData.logo];
    [self.logoIV sd_setImageWithURL:logoURL placeholderImage:[UIImage imageNamed:@"smile"]];
    //作者:
    _authorLabel.text = handpickCellData.author;
    //回帖数及最后更新时间
    if ([handpickCellData.reply intValue] == 0) {
        _replyLabel.text = handpickCellData.reply;
        _replyLabel.hidden = YES;
        _lastDateLabel.text = @"抢沙发";
        _lastDateLabel.font = [UIFont systemFontOfSize:16];
        _lastDateLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sofa:)];
        [_lastDateLabel addGestureRecognizer:tap];
        [tap release];
    } else {
        _replyLabel.text = handpickCellData.reply;
        _lastDateLabel.text = handpickCellData.lastDate;
    }
}

#pragma mark - 抢沙发事件

- (void)sofa:(UITapGestureRecognizer *)tapGesture
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"抢沙发" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    [_lastDateLabel removeGestureRecognizer:tapGesture];
    int number = [_replyLabel.text intValue] + 1;
        _replyLabel.hidden = NO;
    _replyLabel.text = [NSString stringWithFormat:@"%d", number];
    _lastDateLabel.font = [UIFont systemFontOfSize:14];
    //最后更新时间:
    if (number == 1) {
        fixationDate = [NSDate date];
    }
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fixationDate];
    NSString *dateString = nil;
    if (timeInterval < 60) {
        dateString = @"刚刚";
    } else if (timeInterval < 3600) {
        dateString = [NSString stringWithFormat:@"%.lf分钟前", timeInterval / 60];
    } else if (timeInterval < 3600 * 24) {
        dateString = [NSString stringWithFormat:@"%.lf小时前", timeInterval / 3600];
    } else if (timeInterval < 3600 * 48) {
        dateString = @"1天前";
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //设置日期格式
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //按照formatter规定的格式,把日期转成字符串
        NSString *timeString = [formatter stringFromDate:fixationDate];
        dateString = timeString;
    }
    _lastDateLabel.text = dateString;
    
}

#pragma mark - 各版块cell样式

//重写setter方法,进行设置
- (void)setStypeCellData:(StypeCellData *)stypeCellData
{
    if (_stypeCellData != stypeCellData) {
        [_stypeCellData release];
        _stypeCellData = [stypeCellData retain];
    }
    //是否加精或置顶:
    if ([stypeCellData.toptype intValue] == 3) {
        _goodIV.hidden = NO;
        self.goodIV.image = [UIImage imageNamed:@"icon_forum_hotpost_zhiding"];
        NSString *string = [NSString stringWithFormat:@"精 %@", stypeCellData.title];
        //标题:
        _titleLabel.text = string;
        [self getTitleFrameOfString:_titleLabel.text];
    } else {
        if ([stypeCellData.good intValue] == 0) {
            _goodIV.hidden = YES;
            //标题:
            _titleLabel.text = stypeCellData.title;
            [self getTitleFrameOfString:_titleLabel.text];
        } else {
            if ([stypeCellData.good intValue] == 1) {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing1"];
            } else if ([stypeCellData.good intValue] == 2) {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing2"];
            } else {
                _goodIV.image = [UIImage imageNamed:@"icon_forum_featured_jing3"];
            }
            _goodIV.hidden = NO;
            NSString *string = [NSString stringWithFormat:@"精 %@", stypeCellData.title];
            //标题:
            _titleLabel.text = string;
            [self getTitleFrameOfString:_titleLabel.text];
        }
    }
    //插图:判断图片数组元素个数,根据个数显示图片
    [self loadImageWithArray:stypeCellData.pics];
    
    if (stypeCellData.pics.count == 0) {
        [self heightOfModuleCell];
    } else {
        [self picWithHeightOfModuleCell];
    }
    //作者头像
    NSURL *logoURL = [NSURL URLWithString:stypeCellData.logo];
    [self.logoIV sd_setImageWithURL:logoURL placeholderImage:[UIImage imageNamed:@"smile"]];
    //作者:
    _authorLabel.text = stypeCellData.author;
    //回帖数及最后更新时间
    if ([stypeCellData.reply intValue] == 0) {
        _replyLabel.hidden = YES;
        _replyLabel.text = stypeCellData.reply;
        _lastDateLabel.text = @"抢沙发";
        _lastDateLabel.font = [UIFont systemFontOfSize:16];
        _lastDateLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sofa:)];
        [_lastDateLabel addGestureRecognizer:tap];
        [tap release];
    } else {
        _replyLabel.text = stypeCellData.reply;
        _lastDateLabel.text = stypeCellData.lastDate;
    }
}

@end
