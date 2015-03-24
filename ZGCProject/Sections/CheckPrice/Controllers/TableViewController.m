//
//  TableViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/18.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "TableViewController.h"
#import "DetailedParametersTableViewCell.h"
#import "DataSource.h"
#import "Detal.h"


static NSString *cellTabel = @"cell";
@interface TableViewController ()<MyDelegate>

@end

@implementation TableViewController

- (void)dealloc
{
    self.urlString = nil;
    self.proId = nil;
    self.data = nil;
    self.seriesId = nil;
    self.nameArray = nil;
    self.detailArray = nil;
    [super dealloc];
}

- (void)request
{
    self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_ProParam&proId=%@", _proId];
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
    [_data release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详细参数";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(returnBackThePage)];
    
    //注册
    [self.tableView registerClass:[DetailedParametersTableViewCell class] forCellReuseIdentifier:cellTabel];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnBackThePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _nameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detailArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailedParametersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTabel forIndexPath:indexPath];
    Detal *detail = _detailArray[indexPath.section][indexPath.row];
    cell.detail = detail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailedParametersTableViewCell *cell = [[DetailedParametersTableViewCell alloc] init];
    cell.detail = _detailArray[indexPath.section][indexPath.row];
    CGFloat f = [cell heighOfStrings];
    
    return f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _nameArray[section];
}

- (void)viewload:(id)response
{
    self.nameArray = [NSMutableArray arrayWithCapacity:0];
    self.detailArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in response) {
        [_nameArray addObject:dic[@"name"]];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *dict in dic[@"paramArr"]) {
            Detal *detail = [[Detal alloc] initWithDic:dict];
            [array addObject:detail];
            [detail release];
        }
        [_detailArray addObject:array];
        [array release];
    }
    [self.tableView reloadData];
}

@end
