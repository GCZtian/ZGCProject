//
//  HeadSearchViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "HeadSearchViewController.h"
#import "SearchPage.h"
#import "NewsSearchViewController.h"
#import "UIImageView+WebCache.h"

#define MAINSCREENWIDTH self.view.bounds.size.width

@interface HeadSearchViewController ()

@end

@implementation HeadSearchViewController

- (void)dealloc
{
    self.searchPage = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    SearchPage *seach = _searchPage;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarItem_back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle: seach.comCount style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UILabel *searchTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, MAINSCREENWIDTH, 30)];
    searchTitle.textAlignment = NSTextAlignmentCenter;
    searchTitle.font = [UIFont systemFontOfSize:15];
    searchTitle.text = seach.searchTitle;
    searchTitle.numberOfLines = 0;
    [self.view addSubview:searchTitle];
    [searchTitle release];
    
    UILabel *searchData = [[UILabel alloc] initWithFrame:CGRectMake(0, 96, MAINSCREENWIDTH, 18)];
    searchData.font = [UIFont systemFontOfSize:13];
    searchData.text = seach.searchData;
    [self.view addSubview:searchData];
    [searchData release];
    
    UILabel *searchContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, MAINSCREENWIDTH, 20)];
    searchContent.numberOfLines = 0;
    searchContent.text  = seach.searchContent;
    searchContent.font = [UIFont systemFontOfSize:16];
        //自适应行高
    CGRect rect = [seach.searchContent boundingRectWithSize:CGSizeMake(MAINSCREENWIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    searchContent.frame = CGRectMake(0, searchContent.frame.origin.y, MAINSCREENWIDTH, rect.size.height);
    
    [self.view addSubview:searchContent];
    [searchContent release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 134 + rect.size.height, MAINSCREENWIDTH, 240)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:seach.searchPhoto]];
    [self.view addSubview:imageView];
    [imageView release];
    
}

#pragma mark - action

- (void)pressLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];

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
