    //
    //  CustomPictureTableViewCell.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/9.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "CustomPictureTableViewCell.h"

#define MAINSCREENWIDTH self.bounds.size.width
#define WITHE 10
#define FAR 20
#define PHEGIHT [UIScreen mainScreen].bounds.size.height/5
#define BGWITH [UIScreen mainScreen].bounds.size.width

@implementation CustomPictureTableViewCell

- (void)dealloc
{
    self.pictureTitleLabel = nil;
    self.imageViewOne = nil;
    self.imageViewTwo = nil;
    self.imageViewThree = nil;
    self.dataLabel = nil;
    self.pictureCountLabel = nil;
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.pictureTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,BGWITH, PHEGIHT * 2/7)];
//        _pictureCountLabel.font = [UIFont systemFontOfSize:13];
        _pictureTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_pictureTitleLabel];
        [_pictureTitleLabel release];
        
        self.imageViewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0+ WITHE, PHEGIHT * 2/7, (BGWITH -  2*FAR)/3, PHEGIHT * 4 /7)];
        _imageViewOne.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.contentView addSubview:_imageViewOne];
        [_imageViewOne release];
        
        self.imageViewTwo = [[UIImageView alloc] initWithFrame:CGRectMake((BGWITH -  WITHE)/3 * 1 + WITHE, PHEGIHT * 2/7, (BGWITH -  2*FAR)/3, PHEGIHT * 4 /7)];
        _imageViewTwo.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.contentView addSubview:_imageViewTwo];
        [_imageViewTwo release];
        
        self.imageViewThree = [[UIImageView alloc] initWithFrame:CGRectMake((BGWITH -  WITHE)/3 * 2 + WITHE, PHEGIHT * 2/7, (BGWITH -  2*FAR)/3, PHEGIHT * 4 /7)];
        _imageViewThree.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.contentView addSubview:_imageViewThree];
        [_imageViewThree release];
        
        self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(WITHE, PHEGIHT * 6/7,3 * FAR, PHEGIHT * 1/7)];
        _dataLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_dataLabel];
        [_dataLabel release];
        
        self.pictureCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(BGWITH - 10 * FAR, PHEGIHT * 6/7,10 * FAR - WITHE, PHEGIHT * 1/7)];
        _pictureCountLabel.textAlignment = NSTextAlignmentRight;
        _pictureCountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_pictureCountLabel];
        [_pictureCountLabel release];
      
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
