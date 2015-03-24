//
//  CustomTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ListTableViewCell.h"
#import "ListSource.h"
#import "UIImageView+WebCache.h"


#define IMAGESIZEOFHEIGHT 75
#define IMAGESIZEOFWIDTH 90
#define NAMELABELOFHEIGHT 30
#define NAMELABELOFWIDTH 270
#define PRICELABELOFWIDTH 80
#define PRICELABELOFHEIGHT 30
#define ATTIONOFWIDTH 175
#define ATTIONOFHEIGTH 30
#define STARIMAGEWIDTH 15
#define STARIMAGEHEIGTH 15
#define COMMENTOFWIDTH 65
#define COMMENTOFHIGTH 15
#define SPACE 5
#define SPACEOFHIGTH 10

@implementation ListTableViewCell

- (void)dealloc
{
    self.nameLabel = nil;
    self.priceLabel = nil;
    self.image = nil;
    self.comment = nil;
    self.starView = nil;
    self.imageArray = nil;
    self.attentionLabel = nil;
    self.awardImage = nil;
    self.imaged = nil;
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE, SPACEOFHIGTH, IMAGESIZEOFWIDTH, IMAGESIZEOFHEIGHT)];
        _image.image = [UIImage imageNamed:@"icon_phone"];
        [self addSubview:_image];
        [_image release];
        
        self.awardImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
        [self addSubview:_awardImage];
        [_awardImage release];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + IMAGESIZEOFWIDTH, SPACEOFHIGTH, [UIScreen mainScreen].bounds.size.width - SPACE - IMAGESIZEOFWIDTH, NAMELABELOFHEIGHT)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
        [_nameLabel release];
        
        self.attentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + IMAGESIZEOFWIDTH, SPACEOFHIGTH + _nameLabel.frame.origin.y, ATTIONOFWIDTH, ATTIONOFHEIGTH)];
        _attentionLabel.font = [UIFont systemFontOfSize:13];
        _attentionLabel.numberOfLines = 0;
        [self addSubview:_attentionLabel];
        [_attentionLabel release];
        
        
        self.comment = [[UILabel alloc] initWithFrame:CGRectMake(SPACE + IMAGESIZEOFWIDTH + 15 + 60, 90, 100, 15)];
        _comment.textColor = [UIColor grayColor];
        [self addSubview:_comment];
        [_comment release];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 90, _nameLabel.frame.origin.y, 80, 30)];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_priceLabel];
        [_priceLabel release];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重写set方法对cell进行赋值
- (void)setListSource:(ListSource *)listSource
{
    if (_listSource != listSource) {
        [_listSource release];
        _listSource = [listSource retain];
    }
    _nameLabel.text = _listSource.nameAndSeriesProNum;
    _priceLabel.text = _listSource.price;
    _comment.text = _listSource.comment;
    _attentionLabel.text = _listSource.thisWeekHit;
    
    //在label上设置不同字体大小的文字
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_nameLabel.text];
    
    NSRange range = [_nameLabel.text rangeOfString:@"("];
    if ([_nameLabel.text rangeOfString:@"("].length == 0) {
        _nameLabel.font = [UIFont systemFontOfSize:15];
    } else {
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13] range:NSMakeRange(range.location, _nameLabel.text.length - range.location)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(range.location, _nameLabel.text.length - range.location)];
    } 
    _nameLabel.attributedText = str;
    
    self.starView = [[UIView alloc] initWithFrame:CGRectMake(SPACE + IMAGESIZEOFWIDTH, _attentionLabel.frame.origin.y + _attentionLabel.frame.size.height + 10, 10 * 5, 10)];
    [self.contentView addSubview:_starView];
    
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 5; i++) {
        _imaged = [[UIImageView alloc] initWithFrame:CGRectMake(i * 10, 0, 10, 10)];
        _imaged.image = [UIImage imageNamed:@"icon_pl_list_rating_star_gray"];
        [_imageArray addObject:_imaged];
        [self.starView addSubview:[_imageArray lastObject]];
        [_imaged release];
    }
    
    for (int i = 0; i < [self.listSource.userComentStar floatValue]; i++) {
        UIImageView *v = (UIImageView *)_imageArray[i];
        if (([self.listSource.userComentStar floatValue] - i) < 1.0 && ([self.listSource.userComentStar floatValue] - i) >= 0.5) {
            v.image = [UIImage imageNamed:@"icon_pl_list_rating_star_half"];
        } else if (([self.listSource.userComentStar floatValue] - i) >= 1) {
            v.image = [UIImage imageNamed:@"icon_pl_list_rating_star"];
        }
    }
    
    if (_listSource.award == 3) {
        _awardImage.image = [UIImage imageNamed:@"icon_pl_list_good"];
    } else if (_listSource.award == 1) {
        _awardImage.image = [UIImage imageNamed:@"icon_pl_list_excellent"];
    }else{
        if(_awardImage != nil) {
            _awardImage.image = nil;
        }
    }
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_listSource.imageUrl]];
    
    [self resetLabelFrame:_attentionLabel.text labelWithName:_attentionLabel font:17];
    [self resetLabelFrame:_nameLabel.text labelWithName:_nameLabel font:17];
    [self resetFrames];
    
    

}

//返回cell的高度
- (CGFloat)heighOfString
{
    return self.comment.frame.size.height + self.comment.frame.origin.y + 10;
}

//重新设定Label的高度
- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //重新设定lable的frame
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
}

- (void)resetFrames
{
    CGRect frame = self.attentionLabel.frame;
    self.attentionLabel.frame = CGRectMake(frame.origin.x, self.nameLabel.frame.origin.y + _nameLabel.frame.size.height + 10, frame.size.width, frame.size.height);
    
    frame = self.comment.frame;
    self.comment.frame = CGRectMake(frame.origin.x, _attentionLabel.frame.origin.y + _attentionLabel.frame.size.height + 10, frame.size.width, frame.size.height);
    
    frame = self.priceLabel.frame;
    self.priceLabel.frame = CGRectMake(frame.origin.x, _attentionLabel.frame.origin.y, 90, 30);
    
    frame = self.starView.frame;
    self.starView.frame = CGRectMake(frame.origin.x, _attentionLabel.frame.origin.y + _attentionLabel.frame.size.height + 10, frame.size.width, frame.size.height);
}

@end
