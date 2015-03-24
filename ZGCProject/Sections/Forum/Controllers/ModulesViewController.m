//
//  ModulesViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-12.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "ModulesViewController.h"

#import "ModuleForumsViewController.h"
#import "TQMultistageTableView.h"
#import "DataSource.h"
#import "ModuleSectionData.h"
#import "UIImageView+WebCache.h"
#import "ModuleCellData.h"
#import "HandpickViewController.h"
#import "ForumSearchViewController.h"

#define MARGIN 10
#define IMAGESIZE 60

@interface ModulesViewController ()<TQTableViewDataSource, TQTableViewDelegate, MyDelegate>

@property (nonatomic ,retain) TQMultistageTableView *mTableView;
@property (nonatomic, retain) NSMutableArray *sectionArray;
@property (nonatomic, retain) NSMutableArray *cellArray;
@property (nonatomic, retain) NSMutableArray *imageNameArray;

@end

@implementation ModulesViewController

- (void)dealloc
{
    self.mTableView = nil;
    self.sectionArray = nil;
    self.cellArray = nil;
    self.imageNameArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //搜索按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    [searchButton setBackgroundImage:[UIImage imageNamed:@"CityList_search"] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
     [searchButton setTitle:@"可以直接搜索想找的版块" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    [searchButton release];
    
    //自定义tableView
    self.view.backgroundColor = [UIColor purpleColor];
    self.mTableView = [[TQMultistageTableView alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49 - 30)];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:_mTableView];
    [_mTableView release];
    
    //设置表头
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.font = [UIFont systemFontOfSize:17];
    headerView.text = @"   版块导航";
    self.mTableView.tableView.tableHeaderView = headerView;
    [headerView release];
    
    //设置代理
    DataSource *data = [[DataSource alloc] init];
    [data readData:[NSURL URLWithString:@"http://lib.wap.zol.com.cn/bbs/ios/board.php?vs=383"]];
    data.delegate = self;
    [data release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理传值

//代理重新加载数据
- (void)viewload:(id)response
{
    self.sectionArray = [NSMutableArray arrayWithCapacity:1];
    for (NSDictionary *dic in response[@"list"]) {
        ModuleSectionData *moduleSectionData = [[ModuleSectionData alloc] initWithDictionary:dic];
        
        //----------把数组封装-----注意数组初始化的位置---------------
        self.cellArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *mDic in dic[@"list"]) {
            ModuleCellData *moduleCellData = [[ModuleCellData alloc] initWithDictionary:mDic];
            [self.cellArray addObject:moduleCellData];
            [moduleCellData release];
        }
        moduleSectionData.cellArray = _cellArray;
        [_sectionArray addObject:moduleSectionData];
        [moduleSectionData release];
    }
    [self.mTableView reloadData];
}

#pragma mark - 搜索关联方法

- (void)search
{
    ForumSearchViewController *forumSVC = [[ForumSearchViewController alloc] init];
    UINavigationController *forumNC = [[UINavigationController alloc] initWithRootViewController:forumSVC];
    [forumSVC release];
    [self presentViewController:forumNC animated:YES completion:^{
        
    }];
    [forumNC release];
}

#pragma mark - Table view data source

//设定分区
- (NSInteger)numberOfSectionsInTableView:(TQMultistageTableView *)tableView
{
    return _sectionArray.count;
}

//设定行数
- (NSInteger)mTableView:(TQMultistageTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 6) {
        return 0;
    }
    return [[_sectionArray[section] cellArray] count];
}

//cell视图
- (UITableViewCell *)mTableView:(TQMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TQMultistageTableViewCell";
    UITableViewCell *cell = [mTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIView *view = [[UIView alloc] initWithFrame:cell.bounds] ;
    view.layer.backgroundColor  = [UIColor colorWithRed:246/255.0 green:213/255.0 blue:105/255.0 alpha:1].CGColor;
    view.layer.backgroundColor = [UIColor yellowColor].CGColor;
    view.layer.masksToBounds    = YES;
    view.layer.borderWidth      = 0.5;
    view.layer.borderColor      = [UIColor colorWithRed:250/255.0 green:77/255.0 blue:83/255.0 alpha:1].CGColor;
    cell.backgroundView = view;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ModuleCellData *moduleCD = [_sectionArray[indexPath.section] cellArray][indexPath.row];
    
    //显示论坛名字
    UILabel *bbsnameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    bbsnameLabel.text = moduleCD.bbsName;
    bbsnameLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:bbsnameLabel];
    [bbsnameLabel release];
    
    //显示"帖子"文字
    UILabel *postLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 150, 10, 50, 30)];
    postLabel.text = @"帖子";
    postLabel.font = [UIFont systemFontOfSize:14];
    postLabel.textColor = [UIColor grayColor];
    [view addSubview:postLabel];
    [postLabel release];
    
    //显示帖子数量
    UILabel *postNumLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 10, 90, 30)];
    postNumLabel.textColor = [UIColor grayColor];
    postLabel.font = [UIFont systemFontOfSize:14];
    postNumLabel.text = [NSString stringWithFormat:@"%@", moduleCD.totalDic[@"num"]];
    [view addSubview:postNumLabel];
    [postNumLabel release];

    return cell;
}

#pragma mark - UITableViewDelegate

//给定行高
- (CGFloat)mTableView:(TQMultistageTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


//给定分区高度
- (CGFloat)mTableView:(TQMultistageTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

//分区视图
- (UIView *)mTableView:(TQMultistageTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ModuleSectionData *moduleSD = _sectionArray[section];
    UIView *control = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)] autorelease];
    if (section % 2 == 0) {
        control.backgroundColor = [UIColor colorWithRed:220 / 255. green:222 / 255. blue:223 / 255. alpha:1.0];
    } else {
        control.backgroundColor = [UIColor whiteColor];
    }
    //设置图标照片
    UIImageView *logoImagView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, IMAGESIZE, IMAGESIZE)];
    [logoImagView sd_setImageWithURL:[NSURL URLWithString:moduleSD.pic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [control addSubview:logoImagView];
    [logoImagView release];
    
    //设置显示分类名字
    UILabel *sectionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * MARGIN + IMAGESIZE, MARGIN, 120, IMAGESIZE / 2)];
    sectionNameLabel.textColor = [UIColor blackColor];
    sectionNameLabel.font = [UIFont systemFontOfSize:18];
    sectionNameLabel.text = moduleSD.sectionName;
    [control addSubview:sectionNameLabel];
    [sectionNameLabel release];
    
    //设置显示分类简介:
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * MARGIN + IMAGESIZE, MARGIN + IMAGESIZE / 2, 250, IMAGESIZE / 2)];
    introLabel.textColor = [UIColor grayColor];
    introLabel.font = [UIFont systemFontOfSize:16];
    introLabel.text = moduleSD.sectionIntro;
    [control addSubview:introLabel];
    [introLabel release];
    
    //设置箭头图片
    UIImageView *arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width + 2 * MARGIN - IMAGESIZE, 3 * MARGIN, IMAGESIZE - 4 * MARGIN, IMAGESIZE - 4 * MARGIN)];
    arrowIV.image = [UIImage imageNamed:@"Arrow_down"];
    [control addSubview:arrowIV];
    [arrowIV release];
    return control;
}

//选择分区
- (void)mTableView:(TQMultistageTableView *)tableView didSelectHeaderAtSection:(NSInteger)section
{
    if (section == 6) {
        ModuleCellData *moduleCD = [_sectionArray[section] cellArray][0];
        NSString *urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/list.php?vs=381&bbs=%@&boardid=%@&manuid=0&order=lastdate&page=1&productid=0", moduleCD.paramDic[@"bbs"], moduleCD.paramDic[@"boardid"]];
        
        ModuleForumsViewController *moduleFVC = [[ModuleForumsViewController alloc] init];
        
        //属性传值
        moduleFVC.urlString = urlString;
        moduleFVC.bbsName = moduleCD.bbsName;
        moduleFVC.bbs = moduleCD.paramDic[@"bbs"];
        moduleFVC.boardId = moduleCD.paramDic[@"boardid"];
        
        [self.navigationController pushViewController:moduleFVC animated:YES];
        [moduleFVC release];
    }
}

//选中cell进入详情
- (void)mTableView:(TQMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ModuleCellData *moduleCD = [_sectionArray[indexPath.section] cellArray][indexPath.row];
    if (indexPath.section == 0) {
        //分区为0时进入每日精选版块
        NSString *urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/getJingxuan.php?vs=381&bbs=%@&page=1", moduleCD.paramDic[@"bbs"]];
        
        HandpickViewController *handpickVC = [[HandpickViewController alloc] init];
        
        //属性传值
        handpickVC.urlString = urlString;
        handpickVC.number = moduleCD.totalDic[@"num"];
        handpickVC.bbsName = moduleCD.bbsName;
        
        [self.navigationController pushViewController:handpickVC animated:YES];
        [handpickVC release];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/bbs/ios/list.php?vs=381&bbs=%@&boardid=%@&manuid=0&order=lastdate&page=1&productid=0", moduleCD.paramDic[@"bbs"], moduleCD.paramDic[@"boardid"]];
        
        ModuleForumsViewController *moduleFVC = [[ModuleForumsViewController alloc] init];
        
        //属性传值
        moduleFVC.urlString = urlString;
        moduleFVC.bbsName = moduleCD.bbsName;
        moduleFVC.bbs = moduleCD.paramDic[@"bbs"];
        moduleFVC.boardId = moduleCD.paramDic[@"boardid"];
        
        [self.navigationController pushViewController:moduleFVC animated:YES];
        [moduleFVC release];
    }
}

#pragma mark - 分区展开or关闭

//header展开
- (void)mTableView:(TQMultistageTableView *)tableView willOpenHeaderAtSection:(NSInteger)section
{
}

//header关闭
- (void)mTableView:(TQMultistageTableView *)tableView willCloseHeaderAtSection:(NSInteger)section
{
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
