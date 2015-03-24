//
//  SearchViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//


#import "SearchViewController.h"
#import "DataSource.h"
#import "ListViewContrioller.h"

#define INTERVAL 8
#define INTERVALED 5
#define WIGHTH [UIScreen mainScreen].bounds.size.width - 8 - 50
#define HIGHTH 30

@interface SearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, MyDelegate>

@end

@implementation SearchViewController

- (void)dealloc
{
    self.searchBar = nil;
    self.url = nil;
    self.arrayName = nil;
    self.selfTabelView = nil;
    self.resultLabel = nil;
    self.dataSource = nil;
    [super dealloc];
}

- (void)request
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(INTERVAL, INTERVALED, WIGHTH, HIGHTH)];
    _searchBar.placeholder = @"搜索产品";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
    [_searchBar release];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = button;
    [button release];
    
    self.selfTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0,  0, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStylePlain];
    _selfTabelView.tableFooterView = [UIView new];
    
    _selfTabelView.dataSource = self;
    _selfTabelView.delegate = self;
    [self.view addSubview:_selfTabelView];
    [_selfTabelView release];
    
    self.resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 3, 100, 200, 100)];
    _resultLabel.textColor = [UIColor grayColor];
    _resultLabel.text = @"没有搜索结果";
    _resultLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_resultLabel];
    [_resultLabel release];
    self.dataSource = [[DataSource alloc] init];
    _dataSource.delegate = self;
    [_dataSource release];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndefier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefier];
    }
    cell.textLabel.text = _arrayName[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewContrioller *list = [[ListViewContrioller alloc] init];
    list.keyWord = [[self.selfTabelView cellForRowAtIndexPath:indexPath].textLabel.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.searchBar.hidden = YES;
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

- (void)viewload:(id)response
{
    __block SearchViewController *selfBlock = self;
    selfBlock.arrayName = [NSMutableArray arrayWithCapacity:0];
    for (NSString *name in response) {
        [_arrayName addObject:name];
    }
    [_selfTabelView reloadData];
}

- (void)cancle
{
    [_searchBar removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.arrayName == nil) {
        [self.arrayName removeAllObjects];
        _resultLabel.hidden = YES;
    } else {
        _resultLabel.hidden = YES;
    }
    if ([searchBar.text isEqualToString:@""]) {
        [self.arrayName removeAllObjects];
//        _resultLabel.hidden = NO;
    }
        
    //当搜索框里的内容发生改变的时候调用读取数据的方法
    
    [_dataSource readData:[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/autoComplateZolM.php?key=%@&m=pro&vs=iph383", [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    [_selfTabelView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
