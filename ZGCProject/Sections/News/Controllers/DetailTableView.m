//
//  DetailTableView.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/11.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetailTableView.h"
#import "MJRefresh.h"
#import "HeadLine.h"
#import "CustomPictureTableViewCell.h"
#import "NewsCustomTableViewCell.h"
#import "PictureCustomTableViewCell.h"
#import "NewsViewController.h"
#import "NewsAndPictureShowDetailViewController.h"
#import "NewaDataHandle.h"
#import "UIImageView+WebCache.h"

@interface DetailTableView ()
{
//    UIActivityIndicatorView *activity;
    
}
@end

@implementation DetailTableView

- (void)dealloc
{
    self.newsViewController = nil;
    self.dataHandle = nil;
    [super dealloc];
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle =  UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark - refresh

- (void)setupRefresh
{
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self addHeaderWithTarget:self action:@selector(headerRereshing)];
        //2. 上拉加载更多
    [self addFooterWithTarget:self action:@selector(footerRereshing)];
        //自动刷新,(进入程序就下拉刷新)
    [self headerBeginRefreshing];
}
    //进入刷新状态
- (void)headerRereshing
{
        // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerEndRefreshing];
    });
}

- (void)footerRereshing
{
        // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
        
        [[NewaDataHandle defaultNewDataHandle] readData:self.newsViewController.idCount pageNumber:++_pageNumber];
        
        [self footerEndRefreshing];
        
    });
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
        // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeadLine *news = _dataArray[indexPath.row];
        //热榜里显示排行榜
    if ([_newsViewController.idCount isEqualToString:@"8"]) {
        
        NSArray *rankingArray = @[@"top_one", @"top_two", @"top_three"];
        static NSString *cellMark = @"cellMark";
        
        NewsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellMark];
        if (cell == nil) {
            cell = [[[NewsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMark] autorelease];
            if (indexPath.row < 3) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                imageView.tag = 100 + indexPath.row;
                [cell.contentView addSubview:imageView];
                [imageView release];
            }
        }
        if (indexPath.row < 3) {
            UIImageView *imageView = (UIImageView *)[cell viewWithTag:100 + indexPath.row];
            imageView.image = [UIImage imageNamed:rankingArray[indexPath.row]];
        }
        
        cell.titleLabel.text = news.headLineTitle;
        [cell resetLabelFrame:news.headLineTitle];
        cell.dateLabel.text = news.headLineDate;
        cell.rightCountLabel.text = news.headLineCount;
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:news.headLinePhoto]];
        return cell;
        
    } else {
        
        if ([news.type  isEqual: @"6"]) {
            
            static NSString *cellMarkCustom = @"cellMarkCustom";
            CustomPictureTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:cellMarkCustom];
            if (customCell == nil) {
                customCell = [[[CustomPictureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMarkCustom] autorelease];
            }
            
            [customCell.imageViewOne sd_setImageWithURL:[NSURL URLWithString:news.mPictureArray[0]]];
            [customCell.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:news.mPictureArray[1]]];
            [customCell.imageViewThree sd_setImageWithURL:[NSURL URLWithString:news.mPictureArray[2]]];
            
            customCell.pictureTitleLabel.text = news.headLineTitle;
            customCell.dataLabel.text = news.headLineDate;
            customCell.pictureCountLabel.text = [NSString stringWithFormat:@"%@ %@",news.pictureCount,news.headLineCount ];
            return customCell;
            
        } else {
            
            if ([news.type  isEqual: @"0"]) {
                static NSString *cellNewsCustom = @"cellNewsCustom";
                NewsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNewsCustom];
                if (cell == nil) {
                    cell = [[[NewsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNewsCustom] autorelease];
                }
                cell.titleLabel.text = news.headLineTitle;
                [cell resetLabelFrame:news.headLineTitle];
                cell.dateLabel.text = news.headLineDate;
                [cell.photoView sd_setImageWithURL:[NSURL URLWithString:news.headLinePhoto]];
                cell.rightCountLabel.text = news.headLineCount;
                cell.rightCountLabel.backgroundColor = [UIColor whiteColor];
                return cell;
                
            } else {
                static NSString *customTypeIndentifier = @"cusIndentifier";
                NewsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customTypeIndentifier];
                if (cell == nil) {
                    cell = [[[NewsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customTypeIndentifier] autorelease];
                    [cell resetLabelFrame:news.headLineTitle];
                }
                cell.titleLabel.text = news.headLineTitle;
                [cell resetLabelFrame:news.headLineTitle];
                cell.dateLabel.text = news.headLineDate;
                [cell.photoView sd_setImageWithURL:[NSURL URLWithString:news.headLinePhoto]];
                [cell resetTypeFrame:cell.rightCountLabel.text];
                if ([news.type  isEqual: @"4"]) {
                    cell.leftCountLabel.text = news.headLineCount;
                    cell.rightCountLabel.text = @"视频";
                    cell.rightCountLabel.backgroundColor = [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0];
                } else if ([news.type  isEqual: @"18"]) {
                    cell.rightCountLabel.text = @"专题";
                    cell.rightCountLabel.textColor = [UIColor whiteColor];
                    cell.rightCountLabel.backgroundColor = [UIColor redColor];
                }
                return cell;
            }
            
        }
    }
}

#pragma mark - readData

- (void)currentTableView:(DetailTableView *)detaileTableView dataDic:(NSDictionary *)dataDic page:(NSInteger)pageNum
{
   detaileTableView = self;
    self.delegate = self;
    self.dataSource = self;
    [self refresh];
    for (NSDictionary *dic in dataDic[@"list"]) {
        HeadLine *headLine = [[HeadLine alloc] initDictionary:dic];
        [_dataArray addObject:headLine];
        [headLine release];
    }
    
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            //判断是第一次当前页面是否是第一次进入方法
        if (![userDefault objectForKey:[NSString stringWithFormat:@"%@", _newsViewController.idCount]]) {
                //是第一次,将key-value写入到plist文件中
            [userDefault setBool:YES forKey:[NSString stringWithFormat:@"%@", _newsViewController.idCount]];
            [userDefault synchronize];
            [self setupRefresh];
        }
    
    [self reloadData];
    self.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
}

#pragma mark - fresh
    //当在第一页刷新数据的时候,初始化数组
- (void)refresh
{
    if (_pageNumber == 0) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsAndPictureShowDetailViewController *detailVC = [[NewsAndPictureShowDetailViewController alloc] init];
    HeadLine *news = _dataArray[indexPath.row];
    detailVC.pageUrlString = news.detailUrlString;
    [_newsViewController.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadLine *news = _dataArray[indexPath.row];
    if ([news.type isEqual:@"6"] ) {
        return             tableView.rowHeight = [UIScreen mainScreen].bounds.size.height/5;
    } else {
        return 80;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
