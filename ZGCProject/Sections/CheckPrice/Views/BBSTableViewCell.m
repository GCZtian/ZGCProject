//
//  BBSTableViewCell.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "BBSTableViewCell.h"

@implementation BBSTableViewCell

- (void)dealloc
{
    self.handPhoto = nil;
    self.title = nil;
    self.authorName = nil;
    self.data = nil;
    self.comCount = nil;
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 5, 40)];
        [self addSubview:_title];
        _title.numberOfLines = 0;
        _title.font = [UIFont systemFontOfSize:16];
        [_title release];
        
        self.authorName = [[UILabel alloc] initWithFrame:CGRectMake(5, 45, 100, 20)];
        _authorName.font = [UIFont systemFontOfSize:14];
        [self addSubview:_authorName];
        [_authorName release];
        
        self.data = [[UILabel alloc] initWithFrame:CGRectMake(140, 45, 120, 20)];
        _data.font = [UIFont systemFontOfSize:14];
        [self addSubview:_data];
        [_data release];
        
        self.comCount = [[UILabel alloc] initWithFrame:CGRectMake(275, 45, 80, 20)];
        _comCount.font = [UIFont systemFontOfSize:14];
        [self addSubview:_comCount];
        [_comCount release];
        
        
    }
    return self;
}

- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label;
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(label.bounds.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
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
