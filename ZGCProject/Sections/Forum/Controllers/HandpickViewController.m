//
//  HandpickViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-9.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HandpickViewController.h"

#import "DataSource.h"
#import "CustomCell.h"
#import "HandpickCellData.h"
#import "PostViewController.h"
#import "MJRefresh.h"
#import "QGLShareActivity.h"

static NSString *cellIdentifier = @"handpickCell";

@interface HandpickViewController ()<MyDelegate, QGLShareActivityDelegate>
{
    int totalPage;
    QGLShareActivity *shareActivity;
    UIBarButtonItem *ringtItem;
}

@property (nonatomic, retain) DataSource *data;
@property (nonatomic, retain) NSNumber *total;
@property (nonatomic, retain) NSMutableArray *rowArray;
@property (nonatomic, assign) int pageNumber;

@end

@implementation HandpickViewController

- (void)dealloc
{
    self.bbsName = nil;
    self.urlString = nil;
    self.number = nil;
    self.data = nil;
    self.total = nil;
    self.rowArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:cellIdentifier];
    self.navigationItem.title = _bbsName;
    //设置导航条标题颜色,字体大小等等
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //右侧分享按钮
    ringtItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_forum_board_share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    ringtItem.tag = 1000;
    self.navigationItem.rightBarButtonItem = ringtItem;
    [ringtItem release];
   
    self.rowArray = [NSMutableArray arrayWithCapacity:0];
    
    self.data = [[DataSource alloc] init];
    //设置代理传参
    self.data.delegate = self;
    //调用网络请求
    [_data readData:[NSURL URLWithString:_urlString]];
    [_data release];
   
    [self setupRefresh];
    
    //得到刷新总页数
    if ([_number integerValue] % 15 != 0) {
         totalPage = [_number intValue] / 15 + 1;
    } else {
        totalPage = [_number intValue] / 15;
    }
    //刷新页数初始设置为1
    self.pageNumber = 1;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 分享事件及分享代理方法

//分享:
- (void)share
{
    if (ringtItem.tag == 1000) {
        NSArray *name = @[@"微信好友", @"微信朋友圈", @"QQ空间", @"QQ好友", @"新浪微博", @"腾讯微博", @"电子邮件", @"复制衔接"];
        
        NSArray *arr = @[@"icon_WeChat", @"icon_WeChatFriend", @"icon_QQZone", @"icon_QQ", @"icon_sina", @"icon_TencentBlog", @"icon_email", @"icon_copy"];
        
        shareActivity = [[QGLShareActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:name withShareButtonImagesName:arr];
        [shareActivity showInView:self.view];
        ringtItem.tag = 1001;
    } else {
        [shareActivity removeFromSuperview];
        ringtItem.tag = 1000;
    }
}

//分享遵守代理方法
- (void)didClickedWhichOne:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时无法登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

- (void)didClickedCancel
{
    ringtItem.tag = 1000;
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
    __block HandpickViewController *blockSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 1.
        //调用网络请求
         blockSelf.urlString = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d", _pageNumber] withString:@"page=1"];
        
        [_data readData:[NSURL URLWithString:_urlString]];
         // 2.
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [blockSelf.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    __block HandpickViewController *blockSelf = self;
    if (_pageNumber < totalPage) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //调用网络请求
            blockSelf.urlString = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d", _pageNumber] withString:[NSString stringWithFormat:@"page=%d", ++_pageNumber]];
            [_data readData:[NSURL URLWithString:_urlString]];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [blockSelf.tableView footerEndRefreshing];
         });

    } else {
        self.tableView.footerPullToRefreshText = @"已经是最后一页了";
        self.tableView.footerReleaseToRefreshText = @"已经到最后一页了";
        [self.tableView footerEndRefreshing];
    }
    
}

#pragma mark - 代理传值

//执行代理协议方法
- (void)viewload:(id)response
{
    //判断上拉加载更多还是下拉刷新
    if (_pageNumber == 1) {
        [_rowArray removeAllObjects];//移除所有数据
    }
    for (NSDictionary *dic in response[@"list"]) {
        HandpickCellData *handpickCD = [[HandpickCellData alloc] initWithDictionary:dic];
        [_rowArray addObject:handpickCD];
        [handpickCD release];
    }
    self.total = response[@"total"];
    if (_rowArray.count != 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowArray.count;
}

//自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //传值
    cell.handpickCellData = _rowArray[indexPath.row];
    //设置边框
    cell.layer.borderColor = [UIColor colorWithRed:0.403 green:0.624 blue:0.510 alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.cornerRadius = 10;
    return cell;
}

#pragma mark - UITableViewDelegate

//点击cell查看详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HandpickCellData *handpickCD = _rowArray[indexPath.row];
    NSString *mString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/detail.php?bbs=%@&boardid=%@&bookid=%@&type=0&page=1&picOpen=1&fontSize=small&iph382", handpickCD.bbs, handpickCD.boardId, handpickCD.bookId];
    
    PostViewController *postVC = [[PostViewController alloc] init];
    postVC.urlString = mString;
    [self.navigationController pushViewController:postVC animated:YES];
    [postVC release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustomCell *cell = [[[CustomCell alloc] init] autorelease];
    cell.handpickCellData = _rowArray[indexPath.row];
    return cell.contentView.frame.size.height;
}

@end
