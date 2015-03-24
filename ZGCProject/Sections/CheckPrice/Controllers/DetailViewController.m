//
//  DetailViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
#import "detailCell.h"
#import "DetailList.h"
#import "DataSource.h"
#import "DetaiParSource.h"
#import "DetaiParameterTableViewCell.h"
#import "ExtraProsDataSource.h"
#import "OfferTableViewCell.h"
#import "MoreNameTableViewCell.h"
#import "MakeOffersView.h"
#import "EvaluatingTableView.h"
#import "ImgNewsViewController.h"
#import "BBSTableView.h"
#import "TableViewController.h"
#import "VidioViewController.h"


static NSString *cellDetail = @"detailCell";
static NSString *detailCells = @"detail";
static NSString *proCell = @"detailPro";
static NSString *systemCell = @"sysetemCell";
static NSString *extraCell = @"extra";
static NSString *moreNameCell = @"more";
@interface DetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MyDelegate>

{
    UISegmentedControl *segemnt;
    UIScrollView *scroll;
    BBSTableView *bbsTableView;
}

@end

@implementation DetailViewController

- (void)dealloc
{
    self.seriesId = nil;
    self.urlString = nil;
    self.data = nil;
    self.detailProArray = nil;
    self.proId = nil;
    self.extraArray = nil;
    self.nameArray = nil;
    self.makeOffers = nil;
    self.segement = nil;
    self.titleArray = nil;
    [super dealloc];
}

- (void)requestDataSource
{
    if ([_seriesId isEqualToString:@"0"] || [_seriesId class] == nil) {
        self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_ProDetail&noParam=1&proId=%@", _proId];
//        http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_ProDetail&noParam=1&proId=368999
    } else {
        self.urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_SeriesDetail&noParam=1&seriesId=%@", _seriesId];
    }
    self.data = [[DataSource alloc] init];
    [_data readData:[NSURL URLWithString:_urlString]];
    _data.delegate = self;
    [_data release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"产品详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cancleToUpThePage)] autorelease];
    
    NSArray *array = @[@"综述", @"报价", @"点评", @"评测", @"论坛"];
    segemnt = [[UISegmentedControl alloc] initWithItems:array];
    [segemnt addTarget:self action:@selector(segementChanged) forControlEvents:UIControlEventValueChanged];
    segemnt.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    segemnt.tintColor = [UIColor orangeColor];
    [segemnt setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateSelected];
    segemnt.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 35);
    [self.view addSubview:segemnt];
    [segemnt release];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 99, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 105)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 5, [UIScreen mainScreen].bounds.size.height - 105);
    scroll.delegate = self;
    [self.view addSubview:scroll];
    [scroll release];
    
    //创建点评界面
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 2, 0, self.view.bounds.size.width, self.view.bounds.size.height - 105)];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_ReviewList&proId=%@&type=index", _proId]];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    [scroll addSubview:web];
    [web release];
    
    self.evaluating = [[EvaluatingTableView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 3, 30, [UIScreen mainScreen].bounds.size.width, scroll.frame.size.height - 30) style:UITableViewStylePlain];
    [scroll addSubview:_evaluating];
    [_evaluating release];
    
    NSArray *titile = @[@"评测", @"视频"];
    self.segement = [[UISegmentedControl alloc] initWithItems:titile];
    _segement.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 3 + 60, 10, [UIScreen mainScreen].bounds.size.width - 120, 20);
    [_segement addTarget:self action:@selector(sentTheDataSource) forControlEvents:UIControlEventValueChanged];
    [scroll addSubview:_segement];
    [_segement release];
    //创建UITabelView
    self.detaiView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, scroll.frame.size.height) style:UITableViewStylePlain];
    _detaiView.showsVerticalScrollIndicator = NO;
    _detaiView.delegate = self;
    _detaiView.dataSource = self;
    [scroll addSubview:_detaiView];
    [_detaiView release];
    
    //注册cell
    [_detaiView registerClass:[DetailTableViewCell class] forCellReuseIdentifier:cellDetail];
    
    [_detaiView registerClass:[detailCell class] forCellReuseIdentifier:detailCells];
    
    [_detaiView registerClass:[DetaiParameterTableViewCell class] forCellReuseIdentifier:proCell];
    
    [_detaiView registerClass:[UITableViewCell class] forCellReuseIdentifier:systemCell];
    
    [_detaiView registerClass:[OfferTableViewCell class] forCellReuseIdentifier:extraCell];
    
    [_detaiView registerClass:[MoreNameTableViewCell class] forCellReuseIdentifier:moreNameCell];
    
    
    //调用代理方法
    [self requestDataSource];
}

#pragma mark - UISegement关联方法

- (void)cancleToUpThePage
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sentTheDataSource
{
    switch (_segement.selectedSegmentIndex) {
        case 0:
            break;
        case 1:{
            VidioViewController *vid = [[VidioViewController alloc] init];
            vid.proid = _proId;
            [self.navigationController pushViewController:vid animated:YES];
            [vid release];
        }
            break;
        case 2:
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:YES];
        }
    }
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0];
    
    if (self.navigationController.navigationBar.translucent == NO) {
        self.navigationController.navigationBar.translucent = YES;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    _segement.selectedSegmentIndex = 0;

}

- (void)viewWillDisappear:(BOOL)animated
{
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:NO];
        }
    }
}

- (void)segementChanged
{
    scroll.contentOffset = CGPointMake(segemnt.selectedSegmentIndex * [UIScreen mainScreen].bounds.size.width, 0);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    segemnt.selectedSegmentIndex = scroll.contentOffset.x / self.view.bounds.size.width;
}

#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return _detailProArray.count + 1;
    } else if (section == 1) {
        return 1;
    } else if (section == 0) {
        return 1;
    } else {
        if (_nameArray.count == 0 || _extraArray.count == 0) {
            return 0;
        }
        return [_extraArray[section - 3] count] + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_nameArray == nil) {
        return 3 + [[_extraArray lastObject] count];
    }
    return 3 + _nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailList *detail = _detailArray[0];
    if (indexPath.section == 0) {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetail forIndexPath:indexPath];
        cell.detailList = detail;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1){
        detailCell *detailed = [tableView dequeueReusableCellWithIdentifier:detailCells forIndexPath:indexPath];
        detailed.selectionStyle = UITableViewCellSelectionStyleNone;
        detailed.detail = detail;
        return detailed;
    } else  if (indexPath.section == 2){
        if (indexPath.row < _detailProArray.count) {
            DetaiParameterTableViewCell *detailPar = [tableView dequeueReusableCellWithIdentifier:proCell forIndexPath:indexPath];
            DetaiParSource *details = _detailProArray[indexPath.row];
            detailPar.detailPar = details;
            detailPar.selectionStyle = UITableViewCellSelectionStyleNone;
            return detailPar;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:systemCell forIndexPath:indexPath];
            cell.textLabel.text = @"查看更多参数";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor blueColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            OfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:extraCell forIndexPath:indexPath];
            if (_titleArray.count == 0) {
                ExtraProsDataSource *extra = _nameArray[indexPath.section - 3];
                [cell.detailedParametersButton addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.extraPros = extra;
                return cell;
            } else {
                ExtraProsDataSource *extra = _titleArray[indexPath.section - 3];
                [cell.detailedParametersButton addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.extraPros = extra;
                return cell;
            }
            
        }
        MoreNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreNameCell forIndexPath:indexPath];
        ExtraProsDataSource *extra = [_extraArray[indexPath.section - 3] objectAtIndex:indexPath.row - 1];
        cell.extraPros = extra;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        detailCell *detail = [[detailCell alloc] init];
        detail.detail = _detailArray[indexPath.row];
        return [detail heighOfStrings];
    } else if (indexPath.section == 2){
        if (indexPath.row < _detailProArray.count) {
            DetaiParameterTableViewCell *cell = [[DetaiParameterTableViewCell alloc] init];
            cell.detailPar = _detailProArray[indexPath.row];
            return [cell heighOfStrings];
        } else {
            return 60;
        }
    } else if (indexPath.section == 0){
        return 231;
    } else {
        if (indexPath.row == 0) {
            return 80;
        } else {
            return 40;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DetailList *list = _detailArray[0];
        if (list.picNumber != 0) {
            ImgNewsViewController *imagae = [[ImgNewsViewController alloc] init];
            imagae.serieasId = _seriesId;
            imagae.ProId = _proId;
            [self.navigationController pushViewController:imagae animated:YES];
            [imagae release];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row >= _detailProArray.count) {
            TableViewController *table = [[TableViewController alloc] init];
            table.proId = _proId;
            [self.navigationController pushViewController:table animated:YES];
            [table release];
        }
    } else {
        if (indexPath.row == 0 && indexPath.section != 1) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            if (_nameArray.count == 0) {
                detailVC.proId = ((ExtraProsDataSource *)_extraArray[indexPath.section - 3]).proId;
            } else {
            detailVC.proId = ((ExtraProsDataSource *)_nameArray[indexPath.section - 3]).proId;
            }
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
            [self.navigationController pushViewController:detailVC animated:YES];
            [detailVC release];
        }
        
    }
}

#pragma mark - DataSourceDelegate
- (void)viewload:(id)response
{
    self.detailArray = [NSMutableArray arrayWithCapacity:0];
    self.detailProArray = [NSMutableArray arrayWithCapacity:0];
    if ([_seriesId isEqualToString:@"0"] || [_seriesId class] == nil) {
        DetailList *detaiList = [[DetailList alloc] initWithDictionary:response[@"proInfo"]];
        [_detailArray addObject:detaiList];
        [detaiList release];
        
        for (NSDictionary *dic in response[@"sortParam"]) {
            DetaiParSource *detailSource = [[DetaiParSource alloc] initWithDic:dic];
            [_detailProArray addObject:detailSource];
            [detailSource release];
        }
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 120)];
        NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Price&proId=%@&extraId=&cityId=260&provinceId=22&vs=iph370", _proId]];
        [web loadRequest:[NSURLRequest requestWithURL:url]];
        [scroll addSubview:web];
        [web release];
        
    } else {
        DetailList *detailList = [[DetailList alloc] initWithDictionary:response[@"seriesInfo"]];
        [_detailArray addObject:detailList];
        [detailList release];
        
        //初始化数组获取数据
        self.nameArray = [NSMutableArray arrayWithCapacity:0];
        self.extraArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response[@"extraPros"]) {
            if ([dic[@"proId"] isEqualToString:@""]) {
                NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dict in dic[@"extraPrice"]) {
                    ExtraProsDataSource *extraPros = [[ExtraProsDataSource alloc] init];
                    extraPros.priceName = dict[@"priceName"];
                    extraPros.price = [NSString stringWithFormat:@"%@%@", dict[@"mark"], dict[@"price"]];
                    extraPros.proId = dict[@"proId"];
                    [array addObject:extraPros];
                    [extraPros release];
                }
                [_extraArray addObject:array];
                [array release];

                
            } else {
                ExtraProsDataSource *extra = [[ExtraProsDataSource alloc] init];
                extra.name = dic[@"name"];
                extra.proId = dic[@"proId"];
                [_nameArray addObject:extra];
                [extra release];
                NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dict in dic[@"extraPrice"]) {
                    ExtraProsDataSource *extraPros = [[ExtraProsDataSource alloc] init];
                    extraPros.priceName = dict[@"priceName"];
                    extraPros.price = [NSString stringWithFormat:@"%@%@", dict[@"mark"], dict[@"price"]];
                    extraPros.proId = dict[@"proId"];
                    [array addObject:extraPros];
                    [extraPros release];
                }
                [_extraArray addObject:array];
                [array release];
   
 
            }
        }
    }
    for (NSDictionary *dic in response[@"paramArr"]) {
        DetaiParSource *detailSource = [[DetaiParSource alloc] initWithDic:dic];
        [_detailProArray addObject:detailSource];
        [detailSource release];
    }
    //创建报价界面
    if (_nameArray.count != 0 ) {
        self.makeOffers = [[MakeOffersView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 120) style:UITableViewStylePlain];
        [scroll addSubview:_makeOffers];
        [_makeOffers release];
        
        self.makeOffers.sectionArray = [NSMutableArray arrayWithCapacity:0];
        
        self.makeOffers.detai = self;
        _makeOffers.titleNameArray = _extraArray;
        _makeOffers.sectionArray = _nameArray;
    }
    
    //创建论坛UITableView
    
    bbsTableView = [[BBSTableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * 4, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114)];
    bbsTableView.detail = self;
    [scroll addSubview:bbsTableView];
    [bbsTableView release];
    //创建评测界面
    
    self.evaluating.detial = self;
    _evaluating.seriesId = _seriesId;
    _evaluating.proID = _proId;
    bbsTableView.productid = _proId;
    
    [_detaiView reloadData];
}

- (void)pressButton
{
    TableViewController *tableViews = [[TableViewController alloc] init];
    tableViews.proId = _proId;
    [self.navigationController pushViewController:tableViews animated:YES];
}



@end
