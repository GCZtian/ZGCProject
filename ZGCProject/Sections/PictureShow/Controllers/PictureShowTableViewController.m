//
//  PictureShowTableViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "PictureShowTableViewController.h"
#import "CustomPictureTableViewCell.h"
#import "NewsAndPictureShowDetailViewController.h"
#import "PictureShowClass.h"
#import "PictureCustomTableViewCell.h"
#import "MJRefresh.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"

#define BATIINTCOLOR [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0]
static NSInteger pageNumber = 1;

@interface PictureShowTableViewController ()

@end

@implementation PictureShowTableViewController

- (void)dealloc
{
    self.pictureArray = nil;
    self.totleArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;

    self.navigationItem.title = @"图赏";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.pictureArray = [NSMutableArray arrayWithCapacity:0];
    [self setupRefresh];
   
    [self readData:pageNumber];

}

#pragma mark - AFNetworking

- (void)readData:(NSInteger)pageNumber
{
    self.totleArray = [[NSMutableArray alloc] initWithCapacity:0];
    
        //创建AFNetworking的请求操作
    AFHTTPRequestOperation *opertion = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/tushang.php?class_id=0&page=%ld&vs=and380&retina=1", (long)pageNumber]]]];
        //设置AFNetworking返回的数据 自动进行json解析
    
        opertion.responseSerializer = [AFJSONResponseSerializer serializer];
    __block PictureShowTableViewController *selfBlock = self;
     [opertion start];
    [opertion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (pageNumber == 1) {
            [_totleArray removeAllObjects];
            [_pictureArray removeAllObjects];
            _flag = NO;
        }
        if (pageNumber <= 50 && !_flag) {
            NSArray *array = responseObject[@"list"];
            [_totleArray addObjectsFromArray:array];
            if (pageNumber == 50) {
                _flag = YES;
            }
        }
        [selfBlock getData];
        [self.tableView reloadData];
        self.tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
  }

#pragma mark - getData

- (void)getData
{
    for (NSDictionary *dic in _totleArray) {
        PictureShowClass *pic = [[PictureShowClass alloc] init];
        pic.pictureTitle = dic[@"title"];
        pic.pictureMArray = dic[@"imgSrc"];
        NSString *dataString = [dic[@"date"] substringWithRange:NSMakeRange(5, 5)];
        pic.data = dataString;
        pic.comNum = [NSString stringWithFormat:@"%@",dic[@"comNum"]];
        pic.pictureCount = [NSString stringWithFormat:@"%@",dic[@"num"]];
        pic.detailUrl = dic[@"url"];
        [_pictureArray addObject:pic];
        [pic release];
    }
}

#pragma mark - refresh

- (void)setupRefresh
{
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        //2. 上拉加载更多
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
    //进入刷新状态
- (void)headerRereshing
{
        // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        pageNumber = 1;
        _flag = NO;
        [self readData:pageNumber];
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
        // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self readData:++pageNumber];
        [self.tableView footerEndRefreshing];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BATIINTCOLOR;
}

#pragma mark - Table view UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _pictureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureShowClass *picClass = _pictureArray[indexPath.row];
    if ([picClass.pictureMArray isKindOfClass:[NSArray class]]) {
        tableView.rowHeight = self.view.bounds.size.height / 5;
        static NSString *customCellIndentifier = @"cell";
        CustomPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIndentifier];
        if (cell == nil) {
            cell = [[[CustomPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIndentifier] autorelease];
        }
    
        cell.pictureTitleLabel.text = picClass.pictureTitle;
        [cell.imageViewOne sd_setImageWithURL:[NSURL URLWithString:picClass.pictureMArray[0]]];
        [cell.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:picClass.pictureMArray[1]]];
        [cell.imageViewThree sd_setImageWithURL:[NSURL URLWithString:picClass.pictureMArray[2]]];
        cell.dataLabel.text = picClass.data;
        if ([picClass.comNum isEqualToString:@"0"]) {
             cell.pictureCountLabel.text = [NSString stringWithFormat:@"%@图 ",picClass.pictureCount];
        }
        else{
        cell.pictureCountLabel.text = [NSString stringWithFormat:@"%@图 %@评论",picClass.pictureCount,picClass.comNum];
        }
        return cell;
        
    } else {
        static NSString *customIndentifier = @"cell1";
        PictureCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customIndentifier];
        if (cell == nil) {
            cell = [[[PictureCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customIndentifier] autorelease];
        }
        tableView.rowHeight = [UIScreen mainScreen].bounds.size.height * 2/8;
        cell.titleLabel.text = picClass.pictureTitle;
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:picClass.pictureMArray]];
        cell.dateLabel.text = picClass.data;
        cell.countLabel.text =[NSString stringWithFormat:@"%@图 ",picClass.pictureCount];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsAndPictureShowDetailViewController *detailVC = [[NewsAndPictureShowDetailViewController alloc] init];
    PictureShowClass *pictureClass = _pictureArray[indexPath.row];
    detailVC.pageUrlString = pictureClass.detailUrl;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}


@end
