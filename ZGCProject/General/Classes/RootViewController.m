//
//  RootViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/7.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "RootViewController.h"
#import "CheckPriceTableViewController.h"
#import "ForumViewController.h"
#import "RankListViewController.h"
#import "NewsViewController.h"
#import "PictureShowTableViewController.h"
#import "MineViewController.h"




@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RankListViewController *checkPriceVC = [[RankListViewController alloc] init];
    UINavigationController *checkNC = [[UINavigationController alloc] initWithRootViewController:checkPriceVC];
    checkNC.navigationBar.tintColor = [UIColor whiteColor];
    [checkPriceVC release];
    
    checkNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"查报价" image:[UIImage imageNamed:@"tabBarItem_pl"] selectedImage:[UIImage imageNamed:@"tabBarItem_pl_selected"]] autorelease];
    
    ForumViewController *forumVC = [[ForumViewController alloc] init];
    UINavigationController *forumNC = [[UINavigationController alloc] initWithRootViewController:forumVC];
    [forumVC release];
    forumNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"论坛" image:[UIImage imageNamed:@"tabBarItem_forum"] selectedImage:[UIImage imageNamed:@"tabBarItem_forum_selected"]] autorelease];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    [mineVC release];
    mineNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabBarItem_user"] selectedImage:[UIImage imageNamed:@"tabBarItem_user_selected"]] autorelease];
    
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    [newsVC release];
    
    newsNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"资讯" image:[UIImage imageNamed:@"tabBarItem_news"] selectedImage:[UIImage imageNamed:@"tabBarItem_news_selected"]] autorelease];

    
    PictureShowTableViewController *pictureShowVC = [[PictureShowTableViewController alloc] init];

    UINavigationController *pictureNC = [[UINavigationController alloc] initWithRootViewController:pictureShowVC];
    [pictureShowVC release];
    pictureNC.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"图赏" image:[UIImage imageNamed:@"tabBarItem_photo"] selectedImage:[UIImage imageNamed:@"tabBarItem_photo_selected"]] autorelease];
    
    self.viewControllers = @[newsNC, checkNC, forumNC, pictureNC, mineNC];
    
    [newsNC release];
    [checkNC release];
    [forumNC release];
    [pictureNC release];
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
