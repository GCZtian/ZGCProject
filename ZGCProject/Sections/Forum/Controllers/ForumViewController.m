//
//  ForumViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ForumViewController.h"

#import "CustomCell.h"
#import "PostViewController.h"
#import "ModulesViewController.h"
#import "DataSource.h"
#import "PostCellData.h"
#import "MJRefresh.h"
#import "ForumSearchViewController.h"

static NSString *cellIdentifier = @"cell";
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ForumViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, MyDelegate>
{
    UISegmentedControl *segmentControl;
}

@property (nonatomic, retain) UIBarButtonItem *rightItem;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSNumber *totalPage;
@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, assign) int pageNumber;

@end

@implementation ForumViewController

- (void)dealloc
{
    self.rightItem = nil;
    self.scrollView = nil;
    self.tableView = nil;
    self.dataArray = nil;
    self.totalPage = nil;
    self.urlString = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // This is a test
    
     //设置页面切换控制器
    segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"热帖", @"版块"]];
    segmentControl.frame = CGRectMake(80, 0, WIDTH - 160, 44);
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor], NSFontAttributeName : [UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
    segmentControl.tintColor = [UIColor clearColor];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentControl;
    [segmentControl release];
    
    if (segmentControl.selectedSegmentIndex == 0) {
        self.rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
        self.navigationItem.rightBarButtonItem = _rightItem;
        [_rightItem release];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    //创建滚动视图
    self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49)] autorelease];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.contentSize = CGSizeMake(WIDTH * 2, HEIGHT - 64 - 49);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    [_scrollView release];
    
    //添加热帖页面
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64 - 49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView release];
    
    self.urlString = @"http://lib.wap.zol.com.cn/bbs/ios/getHotBook.php?vs=381&page=1&userid=";
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
  //设置代理传值
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
//    [_data release];
    self.pageNumber = 1;
    
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 刷新
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerReleaseToRefreshText = @"松开即可刷新";
    self.tableView.headerRefreshingText = @"正在刷新中";
    
    self.tableView.footerReleaseToRefreshText = @"松开加载更多数据";
    self.tableView.footerRefreshingText = @"正在加载中";
}

#pragma mark 开始进入刷新状态

- (void)headerRereshing
{
    // 1.
    //调用网络请求
    __block ForumViewController *blockSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
        blockSelf.urlString = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d", _pageNumber] withString:@"page=1"];
        
        [blockSelf.data readData:[NSURL URLWithString:_urlString]];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [blockSelf.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    __block ForumViewController *blockSelf = self;
    if (_pageNumber < [_totalPage intValue]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //调用网络请求
            blockSelf.urlString = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d", _pageNumber] withString:[NSString stringWithFormat:@"page=%d", ++_pageNumber]];
            [_data readData:[NSURL URLWithString:_urlString]];
            // 2.2秒后刷新表格UI
            [blockSelf.tableView footerEndRefreshing];
        });
        
    } else {
        self.tableView.footerPullToRefreshText = @"已经是最后一页了";
        self.tableView.footerReleaseToRefreshText = @"已经到最后一页了";
        [self.tableView footerEndRefreshing];
    }
}


#pragma mark - 创建版块页面

//创建版块页面
- (void)createModule
{
    ModulesViewController *moduleVC = [[ModulesViewController alloc] init];
    moduleVC.view.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 64 - 49);
    [self addChildViewController:moduleVC];
    [_scrollView addSubview:moduleVC.view];
    [moduleVC release];
}

#pragma mark - 页面选择器

//选中页面跳转
- (void)change:(UISegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            self.navigationItem.rightBarButtonItem = _rightItem;
            _scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            self.navigationItem.rightBarButtonItem = nil;
            _scrollView.contentOffset = CGPointMake(WIDTH, 0);
            //创建版块页面
            [self createModule];
            break;
            
        default:
            break;
    }
}

#pragma mark - 搜索

//搜索页面
- (void)search
{
    ForumSearchViewController *forumSVC = [[ForumSearchViewController alloc] init];
    UINavigationController *forumNC = [[UINavigationController alloc] initWithRootViewController:forumSVC];
    [forumSVC release];
    [self presentViewController:forumNC animated:YES completion:^{
                     }];
    [forumNC release];
}

#pragma mark - 代理传值

//遵守协议,执行方法
- (void)viewload:(id)response
{
    //判断当前是下拉刷新, 还是上拉加载
    if (_pageNumber == 1) {
         //解决连续刷新程序出现崩溃的问题,把刷新移除数据放在此处
        [self.dataArray removeAllObjects]; //移除所有数据
    }
    for (NSDictionary *dic in response[@"hotList"]) {
        PostCellData *postCellData = [[PostCellData alloc] initWithDictionary:dic];
        [_dataArray addObject:postCellData];
        [postCellData release];
    }
    self.totalPage = response[@"totalpage"];
    if (_dataArray.count != 0) {
        //解决数据还未请求到就刷新列表的问题
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

//设定行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.postCellData = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.layer.borderColor = [UIColor colorWithRed:0.548 green:0.245 blue:0.487 alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.cornerRadius = 5;
    return cell;
}

#pragma mark - UITableViewDelegate

//选中cell跳转页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostViewController *postVC = [[PostViewController alloc] init];
    
    PostCellData *postCellData = _dataArray[indexPath.row];
  
    postVC.urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/detail.php?bbs=%@&boardid=%@&bookid=%@&type=0&page=1&picOpen=1&fontSize=small&iph382", postCellData.bbs, postCellData.boatdId, postCellData.bookId];
    
    [self.navigationController pushViewController:postVC animated:YES];
    [postVC release];
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [[[CustomCell alloc] init] autorelease];
    cell.postCellData = _dataArray[indexPath.row];
    return cell.contentView.frame.size.height;
}

#pragma mark - UIScrollViewDelegate

//滚动视图决定版面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
       if (scrollView.contentOffset.x == 0) {
        segmentControl.selectedSegmentIndex = 0;
        self.navigationItem.rightBarButtonItem = _rightItem;
    } else {
        segmentControl.selectedSegmentIndex = 1;
        self.navigationItem.rightBarButtonItem = nil;
        //创建版块页面
        [self createModule];
    }
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
