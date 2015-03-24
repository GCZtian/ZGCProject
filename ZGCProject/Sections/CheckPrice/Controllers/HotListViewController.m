//
//  HotListViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/13.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HotListViewController.h"
#import "HotListTableViewCell.h"
#import "DetailViewController.h"
#import "DataSource.h"
#import "ListSource.h"
#import "MJRefresh.h"
#import "ListTableViewCell.h"
@interface HotListViewController ()<UITableViewDataSource, UITableViewDelegate, MyDelegate>

@end

@implementation HotListViewController

- (void)requestData
{
    self.urlString = [NSString stringWithFormat:@"http:/lib3.wap.zol.com.cn/index.php?c=Iphone_Top&a=ProRank&num=20&page=%d&subcateId=%@", ++_i, _subcateId];
    self.data = [[DataSource alloc] init];
    [self.data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
}

- (void)dealloc
{
    self.topName = nil;
    self.subcateId = nil;
    self.urlString = nil;
    self.allNum = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hotListArray = [NSMutableArray arrayWithCapacity:0];

    // Do any additional setup after loading the view.
    self.navigationItem.title = _topName;
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cancleToUpThePage)] autorelease];
    
    self.HotList = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_HotList];
    [_HotList release];
    
    _HotList.delegate = self;
    _HotList.dataSource = self;
    
    
    //集成刷新控件
    [self setUpRefresh];
    //请求数据
    [self requestData];
    
}

//集成刷新控件
- (void)setUpRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_HotList addHeaderWithTarget:self action:@selector(headerRereshing)];
    [_HotList addFooterWithTarget:self action:@selector(footerRereshing)];
}

//开始进入刷新状态
- (void)headerRereshing
{
    _i = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_HotList reloadData];
        [_HotList headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    if (20 * _i <= [_allNum intValue]) {
        [_HotList reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestData];
            [_HotList reloadData];
            [_HotList footerEndRefreshing];
        });
    } else {
        [_HotList footerEndRefreshing];
    }
}



//给bar关联返回方法
- (void)cancleToUpThePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hotListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        NSString *cellIdentifier = @"123";
        HotListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[HotListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell.starView removeFromSuperview];
        ListSource *list = _hotListArray[indexPath.row];
        cell.listSource = list;
        return cell;

    }
    else{
    NSString *cellIdentifier = @"12345";
    HotListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HotListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.starView removeFromSuperview];
    ListSource *list = _hotListArray[indexPath.row];
        cell.listSource = list;
        return cell;
    }
    
    
}




#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotListTableViewCell *cell = [[HotListTableViewCell alloc] init];
    cell.listSource = _hotListArray[indexPath.row];
    return [cell heighOfString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.proId = ((ListSource *)_hotListArray[indexPath.row]).ID;
    detail.seriesId = ((ListSource *)_hotListArray[indexPath.row]).seriesId;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}


//代理方法
- (void)viewload:(id)response
{
    self.allNum = response[@"allNum"];
    for (NSDictionary *dic in response[@"data"]) {
        ListSource *list = [[ListSource alloc] initDictionary:dic];
        [_hotListArray addObject:list];
        [list release];
    }
    [_HotList reloadData];
}
@end
