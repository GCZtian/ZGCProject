//
//  FirstLaunchesViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "FirstLaunchesViewController.h"
#import "RootViewController.h"

#define MAINWIDTH [UIScreen mainScreen].bounds.size.width
#define MAINHEIGHT [UIScreen mainScreen].bounds.size.height

@interface FirstLaunchesViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scrollViewmy;
    UIPageControl *pageControll;
}

@end

@implementation FirstLaunchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    
    scrollViewmy = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollViewmy.contentSize = CGSizeMake(self.view.bounds.size.width * 4, self.view.bounds.size.height);
    scrollViewmy.delegate = self;
    scrollViewmy.showsHorizontalScrollIndicator = NO;
    scrollViewmy.pagingEnabled = YES;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAINWIDTH * i, 0, MAINWIDTH, MAINHEIGHT)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i + 1]];
        [scrollViewmy addSubview:imageView];
        [imageView release];
        
    }
    
    [self.view addSubview:scrollViewmy];
    [scrollViewmy release];
    
    UIButton *goHomeDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    goHomeDetail.frame = CGRectMake(MAINWIDTH - 85, 20, 70, 40);
    [goHomeDetail addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    goHomeDetail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_bannerskip"]];
    [self.view addSubview:goHomeDetail];
    
    
    
    
    pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, MAINHEIGHT - MAINHEIGHT / 9, MAINWIDTH, 10)];
    pageControll.numberOfPages = 4;
    pageControll.pageIndicatorTintColor = [UIColor blueColor];
    pageControll.currentPageIndicatorTintColor = [UIColor orangeColor];
    [pageControll addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControll];
    [pageControll release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(MAINWIDTH * 3 + MAINWIDTH / 4, MAINHEIGHT - MAINHEIGHT / 10, MAINWIDTH / 2 , 30);
    [button setTitle:@"立即体验" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [scrollViewmy addSubview:button];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControll.currentPage = scrollViewmy.contentOffset.x / self.view.bounds.size.width;
}

- (void)pageControl:(UIPageControl *)page
{
    scrollViewmy.contentOffset = CGPointMake(self.view.bounds.size.width * pageControll.currentPage, 0);
}

- (void)pressButton:(UIButton *)button
{
    RootViewController *rootVC = [[RootViewController alloc] init];
    rootVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: rootVC animated:YES completion:^{
    }];
    [rootVC release];
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
