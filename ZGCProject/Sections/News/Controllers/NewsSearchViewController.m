    //
    //  SearchViewController.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/7.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "NewsSearchViewController.h"
#import "DataSource.h"
#import "Navigation.h"
#import "NewsCustomTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "SearchPage.h"
#import "CustomPictureTableViewCell.h"
#import "MJRefresh.h"
#import "HeadSearchViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DataSource.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255. green:g/255. blue: b/255. alpha :a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)

    //static NSString *cellIndentifier = @"cell";

@interface NewsSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MyDelegate>
{
    UITableView *selfTableView;
    UISearchBar *searchView;
    UILabel *resultLabel;
}
@end

@implementation NewsSearchViewController

- (void)dealloc
{
    self.dataSource = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarItem_back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftButton release];
        //创建搜索框
    searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    searchView.delegate = self;
    searchView.placeholder = @"请输入关键词";
    searchView.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:searchView];
    [searchView release];
        //创建tableView
    selfTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  104, self.view.bounds.size.width, self.view.bounds.size.height - 148) style:UITableViewStylePlain];
    selfTableView.tableFooterView = [UIView new];
    
    selfTableView.dataSource = self;
    selfTableView.delegate = self;
    [self.view addSubview:selfTableView];
    [selfTableView release];
    
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 3, 100, 200, 100)];
    resultLabel.textColor = [UIColor grayColor];

    resultLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:resultLabel];
    [resultLabel release];
    self.dataSource = [[DataSource alloc] init];
    _dataSource.delegate = self;
    [_dataSource release];

    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchPage  *searchPage = _dataArray[indexPath.row];
    
   static NSString *cellNewsCustom = @"picCustomIndentifier";
    NewsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNewsCustom];
    tableView.rowHeight = 80;
    if (cell == nil) {
        cell = [[[NewsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNewsCustom] autorelease];
    }
    cell.titleLabel.text = searchPage.searchTitle;
    [cell.photoView setImageWithURL:[NSURL URLWithString:searchPage.searchPhoto]];
    cell.rightCountLabel.text = searchPage.comCount;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadSearchViewController *seachVC = [[HeadSearchViewController alloc] init];
    SearchPage *seachPage = _dataArray[indexPath.row];
    seachVC.searchPage = seachPage;
    [self.navigationController pushViewController:seachVC animated:YES];
    [seachVC release];
}


#pragma mark - readData

- (void)viewload:(id)response
{
    NSArray *array = response;
    
    if (array.count == 0) {
        resultLabel.text = @"没有搜索结果";
    } else {
        resultLabel.text = @"";
    __block NewsSearchViewController *selfBlock = self;
     selfBlock.dataArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in response) {
        SearchPage *searchPage = [[SearchPage alloc] initWithDictionary:dic];
        [selfBlock.dataArray addObject:searchPage];
        [searchPage release];
    }
  }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
        //当搜索框里的内容发生改变的时候调用读取数据的方法
    [_dataSource readData:[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/hot_doc1.3.php?class_id=9999&page=1&keyword=%@", [searchView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    [selfTableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)pressLeftButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
