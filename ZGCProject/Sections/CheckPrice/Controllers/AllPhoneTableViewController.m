//
//  AllPhoneTableViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "AllPhoneTableViewController.h"
#import "DetailViewController.h"
#import "ListTableViewCell.h"
#import "DataSource.h"
#import "ListSource.h"
#import "MJRefresh.h"


static NSString *allPhoneCell = @"allPhone";
@interface AllPhoneTableViewController ()<MyDelegate>

@end

@implementation AllPhoneTableViewController

- (void)dealloc
{
    self.urlString = nil;
    self.allNumber = nil;
    self.subId = nil;
    self.data = nil;
    self.allPhoneArray = nil;
    [super dealloc];
}

- (void)requestData
{
    self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_List&noParam=1&subcateId=%@&manuId=&keyword=&priceId=noPrice&paramVal=&orderBy=&num=20&page=%d", _subId, ++self.i];
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
    [_data release];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allPhoneArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:allPhoneCell];
    
    //调用请求数据方法
    [self requestData];
    
    //集成刷新控件
    [self setUpRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//集成刷新控件
- (void)setUpRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //设置刷新文字
    self.tableView.headerPullToRefreshText = @"下拉刷新";
    self.tableView.headerReleaseToRefreshText = @"放开我";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerPullToRefreshText = @"上拉加载更多";
    self.tableView.footerReleaseToRefreshText = @"放开我";
    self.tableView.footerRefreshingText = @"数据正在加载中";
}

//开始进入刷新状态
- (void)headerRereshing
{
    _i = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    if (20 * _i <= [_allNumber intValue]) {
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestData];
            [self.tableView reloadData];
            [self.tableView footerEndRefreshing];
        });
    } else {
        [self.tableView footerEndRefreshing];
    }
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allPhoneArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:allPhoneCell forIndexPath:indexPath];
    [cell.starView removeFromSuperview];
    ListSource *listCell = _allPhoneArray[indexPath.row];
    
    cell.listSource = listCell;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [[ListTableViewCell alloc] init];
    cell.listSource = _allPhoneArray[indexPath.row];
    return [cell heighOfString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.seriesId = ((ListSource *)_allPhoneArray[indexPath.row]).seriesId;
    detail.proId = ((ListSource *)_allPhoneArray[indexPath.row]).ID;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}

- (void)viewload:(id)response
{
    self.allNumber = response[@"allNum"];
    for (NSDictionary *dic in response[@"data"]) {
        ListSource *list = [[ListSource alloc] initDictionary:dic];
        [_allPhoneArray addObject:list];
        [list release];
    }
    [self.tableView reloadData];
}

@end
