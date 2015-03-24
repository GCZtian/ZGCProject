//
//  VidioViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "VidioViewController.h"
#import "DataSource.h"
#import "VCRDataSource.h"
#import "PostViewController.h"
#import "VCRcell.h"

static NSString *celled = @"celled";
static BOOL flag;
@interface VidioViewController ()<MyDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation VidioViewController


- (void)requestTheData
{
    self.url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Video&noParam=1&proId=%@&verParam=383", _proid];
    self.data = [[DataSource alloc] init];
    _data.delegate = self;
    [_data readData:[NSURL URLWithString:_url]];
    [_data release];
}

- (void)please:(NSString *)vid
{
    self.url = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/comment/comment_201403.php?id=v%@&vs=iph361", vid];
    self.data = [[DataSource alloc] init];
    _data.delegate = self;
    [_data readData:[NSURL URLWithString:_url]];
    [_data release];
}

- (void)dealloc
{
    self.proid = nil;
    self.VCRView = nil;
    self.url = nil;
    self.titleArray = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"视频简介";
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(returnTheUp)];
    self.navigationItem.leftBarButtonItem = barButton;
    [barButton release];
    
    self.VCRView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    _VCRView.delegate = self;
    _VCRView.dataSource = self;
    _VCRView.tableFooterView = [UIView new];
    [self.view addSubview:_VCRView];
    [_VCRView release];
    

    
    [self requestTheData];
    
    [_VCRView registerClass:[VCRcell class] forCellReuseIdentifier:celled];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSMutableArray *array = (NSMutableArray *)object;
    if (array.count != 0) {
        
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
    flag = NO;
}

- (void)returnTheUp
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VCRcell *cell = [tableView dequeueReusableCellWithIdentifier:celled forIndexPath:indexPath];
    VCRDataSource *vcr = _titleArray[indexPath.row];
    if (!flag) {
        [self please:vcr.vId];
        flag = !flag;
    }
    cell.VCR = vcr;
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    if (_titleArray == nil) {
//        NSString *string = @"该产品下暂无视频介绍";
//        return string;
//    }
//    return nil;
//}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_titleArray.count != 0) {
        PostViewController *post = [[PostViewController alloc] init];
        post.webUrlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/videoDetail.php?id=v%@&isWifi=0&vs=iph361", ((VCRDataSource *)_titleArray[indexPath.row]).vId];
        
        post.proId = ((VCRDataSource *)_titleArray[indexPath.row]).vId;
        
        post.commentNum = [_commentArray firstObject];
        [self.navigationController pushViewController:post animated:YES];
        [post release];
    }
}

- (void)viewload:(id)response
{
    if ([response isKindOfClass:[NSArray class]]) {
        self.titleArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response) {
            VCRDataSource *vcr = [[VCRDataSource alloc] initWithDic:dic];
            [_titleArray addObject:vcr];
            [vcr release];
        }

    } else {
        self.commentArray = [NSMutableArray arrayWithCapacity:0];
        [self.commentArray addObject:[NSString stringWithFormat:@"%@评论", response[@"comment_num"]]];
    }
    
    if (_titleArray.count == 0) {
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2.0, ([UIScreen mainScreen].bounds.size.height - 100) / 2.0 - 100, 100, 100)];
        iamgeView.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.VCRView.tableFooterView addSubview:iamgeView];
        [iamgeView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 150) / 2.0 + 5, ([UIScreen mainScreen].bounds.size.height - 30) / 2.0, 150, 30)];
        label.text = @"该产品下暂无视频";
        label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self.VCRView.tableFooterView addSubview:label];
        [label release];
    }

    [self.VCRView reloadData];
}


@end
