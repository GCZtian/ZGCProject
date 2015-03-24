//
//  ViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "RankListViewController.h"
#import "ListViewContrioller.h"
#import "SearchViewController.h"
#import "RankListTableViewCell.h"
#import "SubcateTableViewCell.h"
#import "CheckPrice.h"
#import "UIImageView+WebCache.h"
#import "DataSource.h"
#import "maNuList.h"
#import "HotListViewController.h"
#import "ListSource.h"
#import "AllPhoneTableViewController.h"




static NSString *subcateCellIdentifier = @"cell";
static NSString *manuCellIdentifier = @"name";
@interface RankListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MyDelegate>


@end

@implementation RankListViewController

- (void)dealloc
{
    self.manuTableView = nil;
    self.subcateTableView = nil;
    self.subIdAndNameArray = nil;
    self.manuArray = nil;
    self.url = nil;
    self.image = nil;
    self.titleArray = nil;
    self.arrayWithTitle = nil;
    self.topArray = nil;
    self.recordIndexPath = nil;
    [super dealloc];
}

- (void)requestData
{
    [_dataSource readData:[NSURL URLWithString:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Subcate&noParam=1&vs=iph370"]];
}

- (void)requestSubcate
{
    CheckPrice *check = self.subIdAndNameArray[0];
    self.url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Manu&noParam=1&subcateId=%@&vs=iph370&interfaceVersion=1", check.subId];
    [_dataSource readData:[NSURL URLWithString:_url]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化数组
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.subcateTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width / 3 + 5, self.view.bounds.size.height - 64 - 49) style:UITableViewStylePlain];
    
    _subcateTableView.delegate = self;
    _subcateTableView.dataSource = self;
    [self.view addSubview:_subcateTableView];
    [_subcateTableView release];
    
    
    self.manuTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 3, 64, [UIScreen mainScreen].bounds.size.width / 3.0 * 2, self.view.bounds.size.height - 113) style:UITableViewStylePlain];//
    _manuTableView.delegate = self;
    _manuTableView.dataSource = self;
    [self.view addSubview:_manuTableView];
    [_manuTableView release];
    
    //注册
    [_subcateTableView registerClass:[SubcateTableViewCell class] forCellReuseIdentifier:subcateCellIdentifier];
    
    [_manuTableView registerClass:[RankListTableViewCell class] forCellReuseIdentifier:manuCellIdentifier];
    
    
    //添加手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnUpThePage)];
    [self.view addGestureRecognizer:swipe];
    [swipe release];
    
    //设置搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 280, 50)];
    searchBar.placeholder = @"请输入产品信息";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    [searchBar release];
    
    //设置动态索引
    

    self.dataSource = [[DataSource alloc] init];
    [self requestData];
    self.dataSource.delegate = self;

    [_dataSource release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - MJNIndexViewDataSource


//关联方法

- (void)returnUpThePage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
    [searchBar resignFirstResponder];
    return NO;
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _manuTableView) {
        return _titleArray.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _manuTableView) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else {
        return [self.manuArray[section - 2] count];
        }
    } else {
        return _subIdAndNameArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _subcateTableView) {
        SubcateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subcateCellIdentifier forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellSelectionStyleNone;
        
        if (indexPath != self.recordIndexPath) {
            cell.mainLabel.layer.borderWidth = 1;
            cell.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        } else {
            cell.mainLabel.layer.borderWidth = 0;
            cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        }
        
        //设置cell的选择样式
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //对cell进行赋值操作
        CheckPrice *check = _subIdAndNameArray[indexPath.row];
        cell.mainLabel.text = check.name;
        cell.mainLabel.font = [UIFont systemFontOfSize:15];
        return cell;
    } else {
        if (indexPath.section == 0) {
            static NSString *systermIdentifier = @"systerm";
            UITableViewCell *systermCell = [tableView dequeueReusableCellWithIdentifier:systermIdentifier];
            if (systermCell == nil) {
                systermCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systermIdentifier];
            }

            systermCell.textLabel.text = @"排行榜";
            systermCell.textLabel.textAlignment = NSTextAlignmentCenter;
            systermCell.textLabel.font = [UIFont systemFontOfSize:20];
            [systermCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            return systermCell;
        } else if (indexPath.section == 1) {
            static NSString *systermIdentifier = @"systerm";

            UITableViewCell *systermCell = [tableView dequeueReusableCellWithIdentifier:systermIdentifier];
            if (systermCell == nil) {
                systermCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systermIdentifier];
            }
            CheckPrice *check = _subIdAndNameArray[self.recordIndexPath.row];
            systermCell.textLabel.text = [NSString stringWithFormat:@"全部%@", check.name];
            systermCell.textLabel.textAlignment = NSTextAlignmentCenter;
            systermCell.textLabel.font = [UIFont systemFontOfSize:20];
            [systermCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            return systermCell;
        } else {
            RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:manuCellIdentifier forIndexPath:indexPath];
            maNuList *manu = [self.manuArray[indexPath.section - 2] objectAtIndex:indexPath.row];
            cell.label.text = manu.names;
            [cell.imageName sd_setImageWithURL:[NSURL URLWithString:manu.phonePic]];
            return cell;
        }
        
        
    }
}


//设置索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _manuTableView) {
        return _arrayWithTitle;
    } else {
        return nil;
    }
}

//设置区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == _manuTableView) {
        return _titleArray[section];
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _manuTableView) {
        return 70;
    } else {
        return 70;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _subcateTableView) {
        self.recordIndexPath = indexPath;
        CheckPrice *check = self.subIdAndNameArray[self.recordIndexPath.row];
        //拼接api
        self.url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Manu&noParam=1&subcateId=%@&vs=iph370&interfaceVersion=1", check.subId];
        [_dataSource readData:[NSURL URLWithString:_url]];
        
        //刷新数据
        SubcateTableViewCell *cell = (SubcateTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.mainLabel.layer.borderWidth = 0;
        
        cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
        [_manuTableView reloadData];
        
    } else {
        ListViewContrioller *detailVC = [[ListViewContrioller alloc] init];
        CheckPrice *check = self.subIdAndNameArray[self.recordIndexPath.row];
        
        if (indexPath.section < 2) {
            if (indexPath.section == 0) {
                HotListViewController *hotList = [[HotListViewController alloc] init];
                [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
                hotList.topName = ((maNuList *)_topArray.firstObject).topName;
                hotList.subcateId = check.subId;
                [self.navigationController pushViewController:hotList animated:YES];
                
            } else if (indexPath.section == 1) {
                AllPhoneTableViewController *allPhone = [[AllPhoneTableViewController alloc] init];
                
                allPhone.subId = check.subId;
                
                [self.navigationController pushViewController:allPhone animated:YES];
            }
        } else {
        maNuList *manu = [self.manuArray[indexPath.section - 2] objectAtIndex:indexPath.row];
        detailVC.manuId = manu.indexes;
        detailVC.subID = check.subId;
        [self.navigationController pushViewController:detailVC animated:YES];
        }
        [detailVC release];
    }
}
- (void)tableViewScrollToTop {
    [_manuTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [_manuTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _subcateTableView) {
        SubcateTableViewCell *cell = (SubcateTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        cell.mainLabel.layer.borderWidth = 1;
        [_manuTableView reloadData];
    }
}

- (void)viewload:(id)response
{
    if (_subIdAndNameArray.count != 0) {
        self.manuArray = [NSMutableArray arrayWithCapacity:0];
        self.arrayWithTitle = [NSMutableArray arrayWithCapacity:0];
        self.titleArray = [NSMutableArray arrayWithCapacity:0];
        self.topArray = [NSMutableArray arrayWithCapacity:1];
        [_titleArray addObject:@"排行榜"];
        [_titleArray addObject:@"筛选"];
        [_arrayWithTitle addObject:@"排"];
        [_arrayWithTitle addObject:@"筛"];
        
        maNuList *list = [[maNuList alloc] init];
        list.topName = response[@"topName"];
        [_topArray addObject:list];
        [list release];
        for (NSDictionary *dic in response[@"brandList"]) {
            [_arrayWithTitle addObject:dic[@"index"]];
            [_titleArray addObject:dic[@"title"]];
            NSMutableArray *smallArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in dic[@"manuArr"]) {
                maNuList *manu = [[maNuList alloc] init];
                manu.names = dict[@"name"];
                manu.phonePic = dict[@"pic"];
                manu.indexes = dict[@"id"];
                [smallArray addObject:manu];
                [manu release];
            }
            [_manuArray addObject:smallArray];
            [smallArray release];
        }

        [self.manuTableView reloadData];
        [self performSelector:@selector(tableViewScrollToTop) withObject:nil afterDelay:.2];

        
    } else{
        self.subIdAndNameArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response) {
            CheckPrice *check = [[CheckPrice alloc] init];
            check.name = dic[@"name"];
            check.subId = dic[@"subId"];
            [_subIdAndNameArray addObject:check];
            [check release];
        }
        [self requestSubcate];
        
        [self.subcateTableView reloadData];
    }
}


@end
