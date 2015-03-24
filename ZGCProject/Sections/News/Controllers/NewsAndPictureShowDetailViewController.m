    //
    //  DetailViewController.m
    //  ZGCProject
    //
    //  Created by lanouhn on 15/1/7.
    //  Copyright (c) 2015年 niutiantian. All rights reserved.
    //

#import "NewsAndPictureShowDetailViewController.h"

@interface NewsAndPictureShowDetailViewController ()<UIWebViewDelegate>
{
    UIActivityIndicatorView *activity;
}
@end

@implementation NewsAndPictureShowDetailViewController

- (void)dealloc
{
    self.pageUrlString = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarItem_back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    [leftButton release];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_pageUrlString]]];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView release];
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        //设置指示器停止时隐藏
    activity.hidesWhenStopped = YES;
    activity.color = [UIColor grayColor];
    activity.center = self.view.center;
    [activity startAnimating];
    [self.view addSubview:activity];
}

- (void)pressLeftButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}


@end
