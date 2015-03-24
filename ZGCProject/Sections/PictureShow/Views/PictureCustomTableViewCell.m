    //
    //  PictureCustomTableViewCell.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/7.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "PictureCustomTableViewCell.h"

#define LABLEHEIGHT 10
#define PHOTHO [UIScreen mainScreen].bounds.size.height * 2/8
#define MainScreen [UIScreen mainScreen].bounds.size.width

@implementation PictureCustomTableViewCell

- (void)dealloc
{
    self.titleLabel = nil;
    self.photoImage = nil;
    self.dateLabel = nil;
    self.countLabel = nil;
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainScreen, PHOTHO * 1 /5)];
        _titleLabel.opaque = YES;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        self.photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(LABLEHEIGHT,PHOTHO * 1/5, MainScreen - 2 *LABLEHEIGHT, PHOTHO * 3/5)];
        _photoImage.opaque = YES;
        _photoImage.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.contentView addSubview:_photoImage];
        [_photoImage release];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(LABLEHEIGHT,PHOTHO * 4/5 , 6 * LABLEHEIGHT, PHOTHO * 1 /5)];
        _dateLabel.opaque = YES;
        _dateLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(MainScreen - 6 * LABLEHEIGHT, PHOTHO * 4/5, 5 * LABLEHEIGHT, PHOTHO * 1 /5)];
        _countLabel.opaque = YES;
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_countLabel];
        [_countLabel release];
        
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

@end
