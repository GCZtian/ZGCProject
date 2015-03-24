//
//  DetailViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ListViewContrioller.h"
#import "ListTableViewCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "OfferTableViewCell.h"
#import "TableViewController.h"
#import "DataSource.h"
#import "ListSource.h"
#import "MJRefresh.h"


static NSString *cellIdentifier = @"detail";
@interface ListViewContrioller ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MyDelegate>


@end

@implementation ListViewContrioller

- (void)dealloc
{
    self.subID = nil;
    self.manuId = nil;
    self.allNum = nil;
    self.keyWord = nil;
    [super dealloc];
}

- (void)pleaseTheData
{
    if (_subID == nil) {
        self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_List&noParam=1&subcateId=&manuId=&keyword=%@&priceId=noPrice&paramVal=&orderBy=&num=20&page=%d", _keyWord, ++self.i];
    } else {
    self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_List&noParam=1&subcateId=%@&manuId=%@&keyword=&priceId=noPrice&paramVal=&orderBy=&num=20&page=%d", _subID, _manuId, ++self.i];
    }
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listArray = [NSMutableArray arrayWithCapacity:0];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cancleToUpThePage)] autorelease];
    
    self.detailView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _detailView.delegate = self;
    _detailView.dataSource = self;
    [self.view addSubview:_detailView];
    [_detailView release];
        
    [_detailView registerClass:[ListTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    
    //设置搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 280, 50)];
    searchBar.placeholder = @"请输入产品信息";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [searchBar release];
    
    
    //调用请求数据的方法
    [self pleaseTheData];
    //集成刷新控件
    [self setUpRefresh];
    
    
}

- (void)cancleToUpThePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:YES];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:NO];
        }
    }
}


//集成刷新控件
- (void)setUpRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_detailView addHeaderWithTarget:self action:@selector(headerRereshing)];
      self.detailView.footerPullToRefreshText = @"已无更多数据";
    [_detailView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.detailView reloadData];
}

//开始进入刷新状态
- (void)headerRereshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.listArray removeAllObjects];
        _i = 0;
        [self pleaseTheData];
        [self.detailView reloadData];
        [_detailView headerEndRefreshing];
    });

}

- (void)footerRereshing
{
    if (20 * _i <= [_allNum intValue]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self pleaseTheData];
            [_detailView footerEndRefreshing];
        });
    } else {
        self.detailView.footerPullToRefreshText = @"已无更多数据";
        [_detailView footerEndRefreshing];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.starView removeFromSuperview];
    ListSource *listCell = _listArray[indexPath.row];
    cell.listSource = listCell;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.seriesId = ((ListSource *)_listArray[indexPath.row]).seriesId;
    detailVC.proId = ((ListSource *)_listArray[indexPath.row]).ID;

    NSLog(@"%@", detailVC.proId);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [[ListTableViewCell alloc] init];
    cell.listSource = _listArray[indexPath.row];
    return [cell heighOfString];
}


//实现代理方法

-(void)viewload:(id)response
{
    self.allNum = response[@"allNum"];
    for (NSDictionary *dic in response[@"data"]) {
        ListSource *list = [[ListSource alloc] initDictionary:dic];
        [_listArray addObject:list];
        [list release];
    }
    [_detailView reloadData];
}

@end
