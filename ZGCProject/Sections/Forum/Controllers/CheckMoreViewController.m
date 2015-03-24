//
//  CheckMoreViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15-1-20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "CheckMoreViewController.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CheckMoreViewController ()
{
    UITextView * textView;
}

@end

@implementation CheckMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.alpha = 0.85;
    //设置背景图
    UIView *bangroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bangroudView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [self.view addSubview:bangroudView];
    [bangroudView release];
    
    //设置多文本输入
    textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 200, WIDTH - 100, 200)];
    textView.backgroundColor = [UIColor greenColor];
    [bangroudView addSubview:textView];
    [textView release];
    
    //设置选择器
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 410, WIDTH - 100, 31)];
    slider.maximumTrackTintColor = [UIColor blueColor];
    slider.minimumTrackTintColor = [UIColor magentaColor];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    [slider addTarget:self action:@selector(chageBlueColor:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
}

//改变颜色
- (void)chageBlueColor:(UISlider *)slider
{
    textView.backgroundColor = [UIColor colorWithRed:0.361 green:0.228 blue:slider.value alpha:1.0];
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
