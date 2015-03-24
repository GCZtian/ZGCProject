//
//  WebViewController.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

{
    UIActivityIndicatorView *activity;
}
@end

@implementation WebViewController

- (void)dealloc
{
    self.ProdId = nil;
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(cancleToUpThePage)] autorelease];
    
    self.navigationItem.title = @"产品报价";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_Price&proId=%@&extraId=&cityId=260&provinceId=22&vs=iph370", _ProdId]];
    NSLog(@"%@", _ProdId);
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    [webView release];
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.frame = CGRectMake(0, 0, 40, 40);
    activity.center = self.view.center;
    [activity startAnimating];
    activity.color = [UIColor grayColor];
    [webView addSubview:activity];
    [activity release];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancleToUpThePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity stopAnimating];
    activity.hidesWhenStopped = YES;
}

@end
