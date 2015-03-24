//
//  BBSTableView.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/17.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "BBSTableView.h"
#import "BBSTableViewCell.h"
#import "DataSource.h"
#import "BBS.h"
#import "MJRefresh.h"
#import "NewsAndPictureShowDetailViewController.h"
#import "DetailViewController.h"


@interface BBSTableView ()<MyDelegate>

@end

@implementation BBSTableView

- (void)dealloc
{
    self.dataSource = nil;
    self.dataArray = nil;
    self.detail = nil;
    self.productid = nil;
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = YES;
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (void)setProductid:(NSString *)productid
{
    if (_productid != productid) {
        [_productid release];
        _productid = [productid retain];
    }
    _myData = [[DataSource alloc] init];
    _myData.delegate = self;
    if (_productid != nil) {
        [_myData readData:[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/client/product_book_list.php?subcateId=57&productId=%@&page=1&vs=iph383", _productid]]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBS *bbs = _dataArray[indexPath.row];
    
    if ([bbs.type isEqualToString:@"1"] || [bbs.type isEqualToString:@"2"]) {
        
        NSString *cellIndentifierauto = @"cellauto";
        BBSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierauto];
        if (cell == nil) {
            cell = [[BBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifierauto];
        }
        tableView.rowHeight = 70;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, 17, 17)];
        imageView.image = [UIImage imageNamed:@"icon_forum_hotpost_jingpin"];
        [cell.title addSubview:imageView];
        cell.title.text = [NSString stringWithFormat:@"    %@", bbs.title];
        [cell resetLabelFrame:cell.title.text labelWithName:cell.title];
        cell.authorName.text = bbs.authorName;
        cell.data.text = bbs.data;
        cell.comCount.text = bbs.comCount;
        return cell;
    }  else {
        
        static NSString *cellIndentifier = @"cell";
        BBSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[BBSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        tableView.rowHeight = 70;
        cell.title.text =bbs.title;
        [cell resetLabelFrame:cell.title.text labelWithName:cell.title];
        cell.authorName.text = bbs.authorName;
        cell.data.text = bbs.data;
        cell.comCount.text = bbs.comCount;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsAndPictureShowDetailViewController *newsDetailVC = [[NewsAndPictureShowDetailViewController alloc] init];
    BBS *bbs = _dataArray[indexPath.row];
    newsDetailVC.pageUrlString = bbs.detailUrl;
    [_detail.navigationController pushViewController:newsDetailVC animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (_dataArray.count == 0) {
        NSString *string = @"没有论坛信息";
        return string;
    } else {
        return nil;
    }
}

#pragma mark protocol

- (void)viewload:(id)response
{
    __block BBSTableView *blockSelf = self;
    blockSelf.productid = response[@"productid"];
    blockSelf.dataArray = [NSMutableArray arrayWithCapacity:0];
    NSArray *array = response[@"list"];
    for (NSDictionary *dic in array) {
        BBS *bbs = [[BBS alloc] initDictionary:dic];
        [_dataArray addObject:bbs];
        [bbs release];
    }
    [blockSelf reloadData];

}




@end
