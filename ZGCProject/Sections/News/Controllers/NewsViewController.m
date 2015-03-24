    //
    //  NewsViewController.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/7.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "NewsViewController.h"
#import "NewsSearchViewController.h"
#import "DataSource.h"
#import "HomePictureClass.h"
#import "NewsAndPictureShowDetailViewController.h"
#import "DetailTableView.h"
#import "NewaDataHandle.h"
#import "Navigation.h"
#import "UIImageView+WebCache.h"

#define BARTINCOLOR [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0]
#define MAINSCREENTWIDTH [UIScreen mainScreen].bounds.size.width


@interface NewsViewController ()<UIScrollViewDelegate, MyDelegate, NetDataDelegate>
{
    UIScrollView *contentView;
    UISegmentedControl *segmentControll;
    UIScrollView *toolView;
    UIScrollView *picScrollView;
}


@end

@implementation NewsViewController

- (void)dealloc
{
    self.dataSource = nil;
    self.mArrayPicture = nil;
    self.netDataSoure = nil;
    self.detailTableView = nil;
    self.dataDic = nil;
    self.idCount = nil;
    self.navigationIDArray = nil;
    self.navigationNameArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENTWIDTH / 3 * 2, 100)];
    [self.view addSubview:scrollview];
    [scrollview release];
    
    toolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    toolView.userInteractionEnabled = YES;
    toolView.contentSize = CGSizeMake(MAINSCREENTWIDTH * 2, 44);
    self.navigationItem.titleView = toolView;
    [toolView release];
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_navigation_search_click"] style:UIBarButtonItemStylePlain target:self action:@selector(pressSearchButton)];
    self.navigationItem.rightBarButtonItem = searchButton;
    [searchButton release];
    
    self.netDataSoure = [NewaDataHandle defaultNewDataHandle];
    _netDataSoure.netDataDelegate =self;
    
    self.dataSource = [[DataSource alloc] init];
        //解析detail网页id和name
    [_dataSource readData:[NSURL URLWithString:@"http://lib.wap.zol.com.cn/ipj/docList.php?class_id=0&page=1&vs=and380&retina=1"]];
        //解析首页图片
    _dataSource.delegate = self;
    [_dataSource readData:[NSURL URLWithString:@"http://lib.wap.zol.com.cn/ipj/classList.php?vs=and380"]];
    [_dataSource release];
        //创建滚动视图
    contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREENTWIDTH, self.view.bounds.size.height - 64)];
    contentView.directionalLockEnabled = YES;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    contentView.contentInset = UIEdgeInsetsZero;
    [self.view addSubview:contentView];
    [contentView release];
    
        //添加tableView
    for (int i = 0; i < 9; i++) {
        DetailTableView *detailTableView = [[DetailTableView alloc] initWithFrame:CGRectMake(MAINSCREENTWIDTH * i, 0, MAINSCREENTWIDTH, self.view.bounds.size.height - 64)];
        detailTableView.newsViewController = self;
        detailTableView.showsVerticalScrollIndicator = YES;
        detailTableView.tag = 1000 + i;
        [contentView addSubview:detailTableView];
        [detailTableView release];
        
    }
        //设置默认detail首页
    self.detailTableView = (DetailTableView *)[contentView viewWithTag:1000 + segmentControll.selectedSegmentIndex];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = BARTINCOLOR;
}

#pragma mark - gesture
    //添加手势进入图片详情页
- (void)tap:(UITapGestureRecognizer *)tap
{
    NewsAndPictureShowDetailViewController *detail = [[NewsAndPictureShowDetailViewController alloc] init];
    HomePictureClass *homePic = _mArrayPicture[tap.view.tag - 2000];
    detail.pageUrlString = homePic.homeUrl;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}

#pragma mark - protocol

    //读取数据,如果类型为字典,解析的是首页图片,如果为数组,解析的是id
- (void)viewload:(id)response
{
    __block NewsViewController *blockSelf = self;
        //首页图片
    if ([response isKindOfClass:[NSDictionary class]]) {
        blockSelf.mArrayPicture = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response[@"pics"]) {
            HomePictureClass *homePicClass = [[HomePictureClass alloc] init];
            homePicClass.homeTit = dic[@"stitle"];
            homePicClass.homePic = dic[@"imgsrc"];
            homePicClass.homeUrl = dic[@"url"];
            
            [_mArrayPicture addObject:homePicClass];
            [homePicClass release];
        }
        
        UITableView *detailTableView = (UITableView *)[contentView viewWithTag:1000];
        
        picScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, MAINSCREENTWIDTH, MAINSCREENTWIDTH / 3 + 25)];
        picScrollView.contentSize = CGSizeMake(MAINSCREENTWIDTH *  _mArrayPicture.count, 0);
        picScrollView.pagingEnabled = YES;
        detailTableView.tableHeaderView = picScrollView;
        [picScrollView release];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAINSCREENTWIDTH * i, 0, MAINSCREENTWIDTH, MAINSCREENTWIDTH / 3 + 25)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 2000 + i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
            [tap release];
            [picScrollView addSubview:imageView];
            [imageView release];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, MAINSCREENTWIDTH / 3 + 25 - 25, MAINSCREENTWIDTH / 3 * 2 + 10, 25)];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.tag = 200 + i;
            [imageView addSubview:titleLabel];
            [titleLabel release];
            
            UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINSCREENTWIDTH - 30, MAINSCREENTWIDTH / 3, 30, 25)];
            countLabel.textColor = [UIColor whiteColor];
            countLabel.font = [UIFont systemFontOfSize:16];
            countLabel.tag = 400 + i;
            [imageView addSubview:countLabel];
            [countLabel release];
            
        }
            //首页图片的加载
        for (int i = 0; i < _mArrayPicture.count; i++) {
            UIImageView *imageView = (UIImageView *)[picScrollView viewWithTag:2000 + i];
            
            HomePictureClass *homePic = _mArrayPicture[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:homePic.homePic]];
            UILabel *titLabel = (UILabel *)[contentView viewWithTag:200 + i];
            titLabel.text = homePic.homeTit;
            UILabel *countLabel = (UILabel *)[contentView viewWithTag:400 + i];
            if (_mArrayPicture.count == 1) {
                NSString *string = nil;
                countLabel.text = string;
            } else {
                NSString *string = [NSString stringWithFormat:@"%d/%ld",i + 1, (unsigned long)_mArrayPicture.count];
                countLabel.text = string;
            }
        }
    } else {
            //id
        blockSelf.navigationTotle = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response) {
            Navigation *navigation = [[Navigation alloc] initWithDictionary:dic];
            [_navigationTotle addObject:navigation];
            [navigation release];
        }
        [blockSelf addGUI];
    }
}

#pragma mark - navigationSegmentControll详情

    //创建segmentController
- (void)addGUI
{
    self.navigationIDArray = [NSMutableArray arrayWithCapacity:0];
    self.navigationNameArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 9; i++) {
        Navigation *navigation = _navigationTotle[i];
        [_navigationIDArray addObject:navigation.navigationID];
        [_navigationNameArray addObject:navigation.navigationName];
    }
    
    segmentControll = [[UISegmentedControl alloc] initWithItems:_navigationNameArray];
    segmentControll.frame = CGRectMake(0, 0, 720, 44);
    segmentControll.selectedSegmentIndex = 0;
    [segmentControll setTintColor:[UIColor clearColor]];
        //设置选中的字体颜色为蓝色
    [segmentControll setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
        //设置未选中的字体颜色为白色
    [segmentControll setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [segmentControll addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventValueChanged];
    [toolView addSubview:segmentControll];
    [segmentControll release];
    contentView.contentSize = CGSizeMake(MAINSCREENTWIDTH * _navigationIDArray.count, 0);
}


#pragma mark - 详情页面数据

- (void)dataRead:(id)response
{
    __block NewsViewController *blockSelf = self;
    blockSelf.dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [_dataDic addEntriesFromDictionary:response];
    
    [blockSelf.detailTableView currentTableView:_detailTableView dataDic:_dataDic page:blockSelf.detailTableView.pageNumber];
}

#pragma mark - buttonAction

    //搜索
- (void)pressSearchButton
{
    NewsSearchViewController *searchVC = [[NewsSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    [searchVC release];
}

- (void)changeIndex:(UISegmentedControl *)change
{
    contentView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width * change.selectedSegmentIndex, 0);
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    segmentControll.selectedSegmentIndex = scrollView.contentOffset.x / MAINSCREENTWIDTH;
    toolView.contentOffset = CGPointMake(scrollView.contentOffset.x / MAINSCREENTWIDTH * 80, 0);
    
    DetailTableView *detail = (DetailTableView *)[contentView viewWithTag:1000 + segmentControll.selectedSegmentIndex];
    if (_detailTableView != detail) {
        
        [_detailTableView release];
        _detailTableView = [detail retain];
        _idCount= _navigationIDArray[segmentControll.selectedSegmentIndex];
        
        [_netDataSoure readData:_idCount pageNumber:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
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
