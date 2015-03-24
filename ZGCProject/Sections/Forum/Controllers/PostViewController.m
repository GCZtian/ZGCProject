//
//  PostViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "PostViewController.h"

#import "QGLShareActivity.h"
#import "NewsAndPictureShowDetailViewController.h"
#import "CheckMoreViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define INTERVAL 10
#define SIZE 34

@interface PostViewController ()<QGLShareActivityDelegate, UIWebViewDelegate>

@end

@implementation PostViewController

- (void)dealloc
{
    self.urlString = nil;
    self.webUrlString = nil;
    self.commentNum = nil;
    self.iD = nil;
    self.proId = nil;
    self.iD = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //重写返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarItem_back_blue"] style:UIBarButtonItemStylePlain target:self action:@selector(goToTheLastPage)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    
    if (_webUrlString != nil) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@", _commentNum] style:UIBarButtonItemStyleDone target:self action:@selector(changeThePage)] autorelease];
        
    } else {
    //添加楼主按钮
    UIBarButtonItem *landlordItem = [[UIBarButtonItem alloc] initWithTitle:@" " style: UIBarButtonItemStylePlain target:self action:@selector(onlyLandlord:)];
    [landlordItem setBackgroundImage:[UIImage imageNamed:@"forum_btn_landlord"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    landlordItem.tag = 1000;
  
    //添加更多按钮
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithTitle:@"1" style: UIBarButtonItemStylePlain target:self action:@selector(chagePage:)];
    moreItem.tintColor = [UIColor clearColor];
    [moreItem setBackgroundImage:[UIImage imageNamed:@"forum_btn_changepage_highlighted_6"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    moreItem.tag = 1100;
    
    self.navigationItem.rightBarButtonItems = @[moreItem, landlordItem];
    [landlordItem release];
    [moreItem release];
    }
    
    self.tabBarController.tabBar.hidden = YES;
    
    //添加下方视图
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 44, [UIScreen mainScreen].bounds.size.width, 44)];
   
    buttonView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    //回帖按钮
    UIButton *replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    replyButton.frame = CGRectMake(INTERVAL, 5, WIDTH - 5 * INTERVAL - 3 * SIZE, 34);
    [replyButton setBackgroundImage:[UIImage imageNamed:@"evaluating_bottom_comment"] forState:UIControlStateNormal];
    [replyButton addTarget:self action:@selector(reply:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:replyButton];
    
    //收藏按钮
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(WIDTH - 3 * INTERVAL - 3 * SIZE, 5, SIZE, 34);
    [collectButton setBackgroundImage:[UIImage imageNamed:@"icon_forum_followed"] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:collectButton];
    
    //分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(WIDTH - 2 * INTERVAL - 2 * SIZE, 5, SIZE, 34);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"icon_forum_board_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:shareButton];
    
    //三点按钮
    UIButton *threePointButton = [UIButton buttonWithType: UIButtonTypeCustom];
    threePointButton.frame = CGRectMake(WIDTH - INTERVAL - SIZE, 2, SIZE, 40);
    [threePointButton setBackgroundImage:[UIImage imageNamed:@"icon_MoreBottom"] forState:UIControlStateNormal];
    [threePointButton addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:threePointButton];
    
    [self.view addSubview:buttonView];
    [buttonView release];
    
    
    [self loadWebView];
    
    
 }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:YES];
        }
    }
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];

    [[UIApplication sharedApplication] setStatusBarHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:48 / 255. green:90 / 255. blue:255 / 255. alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载网页

//加载网页
- (void)loadWebView
{
    //链接网络
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88)];
    webView.backgroundColor = [UIColor colorWithRed:0.968 green:0.806 blue:1.000 alpha:1.000];
    if (_webUrlString != nil) {
        self.urlString = _webUrlString;
    }
    NSURL *url = [NSURL URLWithString:_urlString];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:urlRequest];
    [webView release];
    [urlRequest release];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.frame = CGRectMake(0, 0, 40, 40);
    _activity.center = self.view.center;
    [_activity startAnimating];
    _activity.color = [UIColor grayColor];
    [webView addSubview:_activity];
    [_activity release];

}

#pragma mark - 按钮关联方法

//返回按钮触发事件
- (void)goToTheLastPage
{
    [self.navigationController popViewControllerAnimated:YES];
}

//回帖按钮触发事件
- (void)reply:(UIButton *)button
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"说点什么" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"发帖" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [alertController addAction:alertAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//收藏按钮关联事件
- (void)collect:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"取消收藏" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark - 分享事件及分享代理

//分享关联方法
- (void)share:(UIButton *)button
{
    NSArray *name = @[@"微信好友", @"微信朋友圈", @"QQ空间", @"QQ好友", @"新浪微博", @"腾讯微博", @"电子邮件", @"复制衔接"];
                     
    NSArray *arr = @[@"icon_WeChat", @"icon_WeChatFriend", @"icon_QQZone", @"icon_QQ", @"icon_sina", @"icon_TencentBlog", @"icon_email", @"icon_copy"];
    
    QGLShareActivity *shareActivity = [[QGLShareActivity alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:name withShareButtonImagesName:arr];
    [shareActivity showInView:self.view];
}

//分享遵守代理方法
- (void)didClickedWhichOne:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时不支持登陆" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
    [alertView show];
    [alertView release];
}

- (void)didClickedCancel
{
}

//三点按钮触发事件
- (void)lookMore:(UIButton *)button
{
    CheckMoreViewController *checkMVC = [[CheckMoreViewController alloc] init];
    checkMVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:checkMVC animated:YES completion:^{
        
    }];
    [checkMVC release];
}

//点击楼主按钮触发事件
- (void)onlyLandlord:(UIBarButtonItem *)barButtonItem
{
    if (barButtonItem.tag != 1000) {
        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"forum_btn_landlord"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        barButtonItem.tag = 1000;
        
        self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"type=1" withString:@"type=0"];
        [self loadWebView];
    } else {
        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"forum_btn_landlord_down"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.urlString = [_urlString stringByReplacingOccurrencesOfString:@"type=0" withString:@"type=1"];
        [self loadWebView];
        barButtonItem.tag = 1001;
    }
}

//点击更多按钮触发改变页数事件
- (void)chagePage:(UIBarButtonItem *)barButtonItem

{
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *destructiveButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"这只是个空模板" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
     }];
    
    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
     }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:destructiveAction];
    
    // Configure the alert controller's popover presentation controller if it has one.
    UIPopoverPresentationController *popoverPresentationController = [alertController popoverPresentationController];
    if (popoverPresentationController) {
        popoverPresentationController.sourceRect = CGRectMake(0, 0, 375, 80);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 375, 200)];
        popoverPresentationController.sourceView = view;
        popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)changeThePage
{
    NewsAndPictureShowDetailViewController *news = [[NewsAndPictureShowDetailViewController alloc] init];
    if (_iD == nil) {
        news.pageUrlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/doc_comment_new.php?id=v%@&vs=iph382&imei=EE37CC80-7D20-404E-8433-29CED2F7952D", _proId];
    } else {
        news.pageUrlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/doc_comment_new.php?id=%@&vs=iph382&imei=F312B7D9-9566-4B9F-801D-80FE19EFD4F9", _iD];
    }
    [self.navigationController pushViewController:news animated:YES];
    [news release];
}

#pragma mark - UIWebDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activity stopAnimating];
    _activity.hidesWhenStopped = YES;
}

@end
