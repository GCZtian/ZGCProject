//
//  ModuleForumsViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-8.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ModuleForumsViewController.h"

#import "CustomCell.h"
#import "PostViewController.h"
#import "StypeCellData.h"
#import "DataSource.h"
#import "QGLShareActivity.h"
#import "MJRefresh.h"

static NSString *cellIdentifier = @"cell213";

@interface ModuleForumsViewController ()<UITableViewDataSource, UITableViewDelegate, MyDelegate, QGLShareActivityDelegate, UIAlertViewDelegate>
{
    UILabel *followLabel;
    UILabel *postLabel;
    QGLShareActivity *shareActivity;
    UIBarButtonItem *ringtItem;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) DataSource *data;
@property (nonatomic, assign) int pageNumber;

@end

@implementation ModuleForumsViewController

- (void)dealloc
{
    self.tableView = nil;
    self.urlString = nil;
    self.collectNum = nil;
    self.postNum = nil;
    self.totalPage = nil;
    self.rowArray = nil;
    self.bbsName = nil;
    self.bbs = nil;
    self.boardId = nil;
    self.data = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"";
    
    //自适应高度关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49 - 64)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    //添加页面加载选择器
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"新回复", @"新发帖", @"精华"]];
    segmentControl.frame = CGRectMake(80, 5, [UIScreen mainScreen].bounds.size.width - 160, 34);
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(changeLoadData:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentControl;
    [segmentControl release];
    
    //右侧分享按钮
    ringtItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_forum_board_share"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    ringtItem.tag = 1000;
    self.navigationItem.rightBarButtonItem = ringtItem;
    [ringtItem release];
    
    //注册自定义cell
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:cellIdentifier];
    
    //设置表头
    UIView *forumView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    followLabel.backgroundColor = [UIColor colorWithRed:0.864 green:0.678 blue:0.975 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, [UIScreen mainScreen].bounds.size.width - 30, 25)];
    titleLabel.text = _bbsName;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [forumView addSubview:titleLabel];
    [titleLabel release];
    
    //关注数显示label
    followLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 85, 30)];
    followLabel.textColor = [UIColor grayColor];
    followLabel.font = [UIFont systemFontOfSize:13];
    [forumView addSubview:followLabel];
    [followLabel release];
    
    //帖子数显示label
    postLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 30, 100, 30)];
    postLabel.font = [UIFont systemFontOfSize:13];
    postLabel.textColor = [UIColor grayColor];
    [forumView addSubview:postLabel];
    [postLabel release];
    
    //加关注按钮
    UIButton *addFollowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addFollowButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 28, 100, 28);
    [addFollowButton setBackgroundImage:[UIImage imageNamed:@"icon_forum_board_attforum"] forState:UIControlStateNormal];
    [addFollowButton setBackgroundImage:[UIImage imageNamed:@"icon_forum_board_cancelattforum"] forState:UIControlStateSelected];
    [addFollowButton addTarget:self action:@selector(addFollow:) forControlEvents:UIControlEventTouchUpInside];
    [forumView addSubview:addFollowButton];
    
    self.tableView.tableHeaderView = forumView;
    [forumView release];
    
    //设置下方显示toolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 50)];
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postButton.frame = CGRectMake(80,5, [UIScreen mainScreen].bounds.size.width - 160, 40);
    [postButton setImage:[UIImage imageNamed:@"icon_forum_board_replay"] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(writePost) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:postButton];
    [self.view addSubview:toolBar];
    [toolBar release];
    
    self.rowArray = [NSMutableArray arrayWithCapacity:0];

    //创建dataSource对象并执行代理方法
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
    [_data release];
    
    self.pageNumber = 1;
    
    [self setupRefresh];
}


//视图将要出现时重新加载数据
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    __block ModuleForumsViewController *blockSelf = self;
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
    __block ModuleForumsViewController *blockSelf = self;
    if (_pageNumber < [_totalPage intValue]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //调用网络请求
            blockSelf.urlString = [_urlString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"page=%d", _pageNumber] withString:[NSString stringWithFormat:@"page=%d", ++_pageNumber]];
            [_data readData:[NSURL URLWithString:_urlString]];
            [blockSelf.tableView footerEndRefreshing];
        });
        
    } else {
        self.tableView.footerPullToRefreshText = @"已经是最后一页了";
        self.tableView.footerReleaseToRefreshText = @"已经到最后一页了";
        [self.tableView footerEndRefreshing];
    }
}

#pragma mark - 代理传值

//代理传值
- (void)viewload:(id)response
{
    if (_pageNumber == 1) {
        [_rowArray removeAllObjects];
    }
    self.collectNum = response[@"collectNum"];
    self.postNum = response[@"list"][@"num"];
    self.totalPage = response[@"list"][@"totalPage"];
    for (NSDictionary *dic in response[@"list"][@"bookList"]) {
        StypeCellData *stypeCD = [[StypeCellData alloc] initWithDictionary:dic];
        [_rowArray addObject:stypeCD];
        [stypeCD release];
    }
    
    //关注数显示:
    followLabel.text = [NSString stringWithFormat:@"关注%@", _collectNum];
    //帖子数显示:
    postLabel.text = [NSString stringWithFormat:@"帖子%@", _postNum];
    
    if (_rowArray.count != 0) {
        [self.tableView reloadData];
    }
}

#pragma mark - 按钮触发关联方法

//视图选择控制器
- (void)changeLoadData:(UISegmentedControl *)segementedControl
{
    switch (segementedControl.selectedSegmentIndex) {
        case 0:
            if ([_urlString containsString:@"wdate"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"wdate" withString:@"lastdate"];
            } else if ([_urlString containsString:@"good"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"good" withString:@"lastdate"];
            }
            [_data readData:[NSURL URLWithString:_urlString]];
            break;
            
        case 1:
            if ([_urlString containsString:@"lastdate"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"lastdate" withString:@"wdate"];
            } else if ([_urlString containsString:@"good"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"good" withString:@"wdate"];
            }
            [_data readData:[NSURL URLWithString:_urlString]];
            break;
            
        case 2:
            if ([_urlString containsString:@"lastdate"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"lastdate" withString:@"good"];
            } else if ([_urlString containsString:@"wdate"]) {
                self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"wdate" withString:@"good"];
            }
            [_data readData:[NSURL URLWithString:_urlString]];
            break;
            
        default:
            break;
    }
}

//加关注
- (void)addFollow:(UIButton *)button
{
    button.selected = !button.selected;
}

//发帖
- (void)writePost
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时不支持发帖" delegate:self cancelButtonTitle:nil
                                              otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

//分享
- (void)share:(UIBarButtonItem *)barButtonItem
{
    if (barButtonItem.tag == 1000) {
        NSArray *name = @[@"微信好友", @"微信朋友圈", @"QQ空间", @"QQ好友", @"新浪微博", @"腾讯微博", @"电子邮件", @"复制衔接"];
        
        NSArray *arr = @[@"icon_WeChat", @"icon_WeChatFriend", @"icon_QQZone", @"icon_QQ", @"icon_sina", @"icon_TencentBlog", @"icon_email", @"icon_copy"];
        
        shareActivity = [[QGLShareActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:name withShareButtonImagesName:arr];
        [shareActivity showInView:self.view];
        barButtonItem.tag = 1001;
    } else {
        [shareActivity removeFromSuperview];
        barButtonItem.tag = 1000;
        }
}

#pragma mark - QGLShareActivityDelegate

//点击item触发事件
- (void)didClickedWhichOne:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时不支持登陆" delegate:self cancelButtonTitle:nil
 otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

//点击取消触发事件(方法内可以不写内容)
- (void)didClickedCancel
{
    ringtItem.tag = 1000;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.stypeCellData = _rowArray[indexPath.row];
    
    //设置边框
    cell.layer.borderColor = [UIColor colorWithRed:0.303 green:0.424 blue:0.710 alpha:1.0].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.cornerRadius = 5;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StypeCellData *stypeCD = _rowArray[indexPath.row];
    NSString *urlString =[NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/detail.php?bbs=%@&boardid=%@&bookid=%@&type=0&page=1&picOpen=1&fontSize=small&iph382", _bbs, _boardId, stypeCD.bookId];
    PostViewController *postVC = [[PostViewController alloc] init];
    postVC.urlString = urlString;
    [self.navigationController pushViewController:postVC animated:YES];
    [postVC release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [[[CustomCell alloc] init] autorelease];
    cell.stypeCellData = _rowArray[indexPath.row];
    return cell.contentView.frame.size.height;
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
