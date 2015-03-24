//
//  VCRcell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "VCRcell.h"
#import "VCRDataSource.h"
#import "UIImageView+WebCache.h"
@implementation VCRcell

- (void)setVCR:(VCRDataSource *)VCR
{
    if (_VCR != VCR) {
        [_VCR release];
        _VCR = [VCR retain];
    }
    self.titleLabel.text = _VCR.title;
    self.dataLabel.text = _VCR.pubdate;
    self.reviewNumLabel.text = _VCR.hits;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:_VCR.pic]];
    
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self resetLabelFrame:self.titleLabel.text labelWithName:self.titleLabel font:15];
}

- (void)resetLabelFrame:(NSString *)aString labelWithName:(UILabel *)label font:(float)size
{
    CGRect frame = label.frame;
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(frame.size.width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //重新设定lable的frame
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, rect.size.height);
}


@end
