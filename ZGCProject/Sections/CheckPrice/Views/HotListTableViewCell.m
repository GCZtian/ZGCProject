//
//  HotListTableViewCell.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HotListTableViewCell.h"
#import "ListSource.h"

@implementation HotListTableViewCell

- (void)dealloc
{
    self.topImage = nil;
    self.label = nil;
    [super dealloc];
}

-(void)setListSource:(ListSource *)listSource
{
    [super setListSource:listSource];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 20, 20)];
    
    self.topImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 28, 30)];
    if ([listSource.topNumber intValue] < 4) {
        _topImage.image = [UIImage imageNamed:@"icon_pl_rank_list_top_3_flag"];
        _label.text = [NSString stringWithFormat:@"%@", listSource.topNumber];
        [_topImage addSubview:_label];
        [_label release];
        [self addSubview:_topImage];
        [_topImage release];
    } else {
        _topImage.image = [UIImage imageNamed:@"icon_pl_rank_list_flag"];
        [self addSubview:_topImage];
        self.label.text = [NSString stringWithFormat:@"%@", listSource.topNumber];
        [_topImage addSubview:_label];
        
        [_topImage release];
        [_label release];
    }
    //重设父类iamge的frame
    CGRect rect = self.image.frame;
    
    self.awardImage.frame = CGRectMake(rect.origin.x + rect.size.width - 30, rect.size.height - 30, 30, 30);
}

@end
