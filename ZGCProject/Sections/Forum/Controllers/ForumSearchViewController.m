//
//  ForumSearchViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-19.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ForumSearchViewController.h"

#import "DataSource.h"
#import "SearchResultData.h"
#import "SearchPostCell.h"
#import "ModuleForumsViewController.h"
#import "PostViewController.h"

@interface ForumSearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, MyDelegate>
{
    UILabel *resultLabel;
    UISearchBar *searchRusultBar;
    UITableView *resultTableView;
    UITapGestureRecognizer *tapGesture;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) DataSource *data;

@end

@implementation ForumSearchViewController

- (void)dealloc
{
    self.dataArray = nil;
    self.data = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationItem.title = @"搜索";
    
    //取消返回按钮
    UIBarButtonItem *canselItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:searchRusultBar action:@selector(back)];
    self.navigationItem.rightBarButtonItem = canselItem;
    [canselItem release];
    
    //搜索框
    searchRusultBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 80)];
    [self.view addSubview:searchRusultBar];
    [searchRusultBar release];
    searchRusultBar.showsCancelButton = YES;
    searchRusultBar.translucent = YES;
    searchRusultBar.showsSearchResultsButton = YES;
    
    searchRusultBar.tintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    searchRusultBar.barTintColor = [UIColor orangeColor];
    searchRusultBar.showsScopeBar = YES;
    searchRusultBar.scopeButtonTitles = @[@"论坛", @"帖子"];
    searchRusultBar.placeholder = @"搜索论坛";
    searchRusultBar.selectedScopeButtonIndex = 0;
    searchRusultBar.scopeBarBackgroundImage = [UIImage imageNamed:@"bg_frame_feedback2"];
    searchRusultBar.delegate = self;
    
    //搜索结果显示视图
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 144, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 144) style:UITableViewStylePlain];
    resultTableView.dataSource = self;
    resultTableView.delegate = self;
    resultTableView.tableFooterView = [UIView new];
    [self.view addSubview:resultTableView];
    [resultTableView release];
    
    //搜索无结果显示文本
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, [UIScreen mainScreen].bounds.size.width - 100, 100)];
    resultLabel.textColor = [UIColor grayColor];
    resultLabel.text = @"暂无搜索历史";
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:resultLabel];
    [resultLabel release];
   
    self.data = [[DataSource alloc] init];
    self.data.delegate = self;
    [_data release];
}

#pragma mark - 返回按钮

- (void)back
{
      [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    if (selectedScope == 0) {
        searchBar.placeholder = @"搜索论坛";
        NSString *string = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/search.php?kword=%@&page=1&type=board&vs=383", [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_data readData:[NSURL URLWithString:string]];

    } else {
        searchBar.placeholder = @"搜索帖子";
        NSString *string = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/search.php?kword=%@&page=1&type=book&vs=383", [searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_data readData:[NSURL URLWithString:string]];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.dataArray == nil) {
        [self.view resignFirstResponder];
        resultLabel.text = @"";
        [self.dataArray removeAllObjects];
        [resultTableView reloadData];
    } else {
        resultLabel.text = @"";
        [self.view resignFirstResponder];
    }
    if ([searchText isEqualToString:@""]) {
        [self.dataArray removeAllObjects];
         resultLabel.text = @"暂无搜索历史";
        [resultTableView reloadData];
    }
    if (searchBar.selectedScopeButtonIndex == 0) {
        NSString *string = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/search.php?kword=%@&page=1&type=board&vs=383", [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_data readData:[NSURL URLWithString:string]];

    } else {
        NSString *string = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/search.php?kword=%@&page=1&type=book&vs=383", [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [_data readData:[NSURL URLWithString:string]];
    }
}

#pragma mark - MyDelegate

- (void)viewload:(id)response
{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in response) {
        SearchResultData *searchRD = [[SearchResultData alloc] init];
        [searchRD setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:searchRD];
        [searchRD release];
    }
    [resultTableView reloadData];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchRusultBar.selectedScopeButtonIndex == 0) {
        static NSString *moduleIdentifier = @"module";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moduleIdentifier];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moduleIdentifier] autorelease];
        }
        cell.textLabel.text = [_dataArray[indexPath.row] bbsname];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *postIdentifier = @"post";
        SearchPostCell *cell = [tableView dequeueReusableCellWithIdentifier:postIdentifier];
        if (!cell) {
            cell = [[[SearchPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postIdentifier] autorelease];
        }
        cell.searchRD = _dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchRusultBar.selectedScopeButtonIndex == 0) {
        return 50;
    }
    return [SearchPostCell heightOfCell:[_dataArray[indexPath.row] title]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (searchRusultBar.selectedScopeButtonIndex == 0) {
        SearchResultData *searchRD = _dataArray[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/list.php?vs=381&bbs=%@&boardid=%@&manuid=0&order=lastdate&page=1&productid=0", searchRD.bbs, searchRD.boardid];
        
        ModuleForumsViewController *moduleFVC = [[ModuleForumsViewController alloc] init];
        
        //属性传值
        moduleFVC.urlString = urlString;
        moduleFVC.bbsName = searchRD.bbsname;
        moduleFVC.bbs = searchRD.bbs;
        moduleFVC.boardId = searchRD.boardid;

        [self.navigationController pushViewController:moduleFVC animated:YES];
        [moduleFVC release];
    } else {
        PostViewController *postVC = [[PostViewController alloc] init];
        SearchResultData *searchRD = _dataArray[indexPath.row];
        postVC.urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/detail.php?bbs=%@&boardid=%@&bookid=%@&type=0&page=1&picOpen=1&fontSize=small&iph382", searchRD.bbsname, searchRD.boardid, searchRD.bookid];
        [self.navigationController pushViewController:postVC animated:YES];
        [postVC release];
    }
}

@end
