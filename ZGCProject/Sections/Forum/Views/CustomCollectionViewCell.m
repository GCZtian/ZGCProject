//
//  CustomCollectionViewCell.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "CustomCollectionViewCell.h"

#define INTERVAL 5
#define TITLE 20
#define LOGOSIZE self.bounds.size.width - 2 * INTERVAL
#define LOGOHEIGHT self.bounds.size.height - 3 * INTERVAL - TITLE

@implementation CustomCollectionViewCell

- (void)dealloc
{
    self.logoIV = nil;
    self.itemTitle = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoIV = [[UIImageView alloc] initWithFrame:CGRectMake(INTERVAL, INTERVAL, LOGOSIZE, LOGOHEIGHT)];
        self.logoIV.layer.cornerRadius = LOGOSIZE / 2;
        self.layer.masksToBounds = YES;
        [self.contentView addSubview:_logoIV];
        [_logoIV release];
        
        self.itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(INTERVAL, 2 * INTERVAL + LOGOHEIGHT, LOGOSIZE, TITLE)];
        self.itemTitle.textColor = [UIColor purpleColor];
        self.itemTitle.textAlignment = NSTextAlignmentCenter;
        self.itemTitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_itemTitle];
        [_itemTitle release];
        _logoIV.userInteractionEnabled = YES;
    }
    return self;
}

@end
