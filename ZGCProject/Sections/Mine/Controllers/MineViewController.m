//
//  MineViewController.m
//  ZGCProject
//
//  Created by lanouhn on 15/1/20.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "MineViewController.h"

#define BARTINCOLOR [UIColor colorWithRed:60 / 255. green:90 / 255. blue:200 / 255. alpha:1.0]
#define MAINWIDTH self.view.bounds.size.width
#define MAINHEIGHT self.view.bounds.size.height

@interface MineViewController ()
{
    UITextView *retroactionText;
}
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 94, 40, 40)];
    imageView.image = [UIImage imageNamed:@"login"];
    [self.view addSubview:imageView];
    
    UILabel *loginLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 94, MAINWIDTH - 150,50)];
    loginLable.text = @"点击登录,查看更多内容";
    loginLable.textColor = [UIColor grayColor];
    loginLable.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:loginLable];
    [loginLable release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    loginButton.frame = CGRectMake(MAINWIDTH - 100, 94, 100, 50);
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    
    
    
    UILabel *retroaction = [[UILabel alloc] initWithFrame:CGRectMake(10, 164, MAINWIDTH, 40)];
    
    retroaction.text = @"意见反馈";
    retroaction.textColor = [UIColor grayColor];
    retroaction.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:retroaction];
    [retroaction release];
    
    retroactionText = [[UITextView alloc] initWithFrame:CGRectMake(10, 210, MAINWIDTH - 20, 50)];
    retroactionText.font = [UIFont systemFontOfSize:15];
    retroactionText.layer.borderWidth = 0.5;
    retroactionText.layer.cornerRadius = 5;
    retroactionText.layer.borderColor = [UIColor grayColor].CGColor;
    retroactionText.textColor = [UIColor grayColor];
    [self.view addSubview:retroactionText];
    [retroactionText release];
    
    UIButton *inpunt = [UIButton buttonWithType:UIButtonTypeSystem];
    [inpunt setTitle:@"提交" forState:UIControlStateNormal];
    inpunt.frame = CGRectMake(MAINWIDTH / 3 + 20, 270, 50, 50);
    [inpunt setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
    [inpunt addTarget:self action:@selector(inpunt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inpunt];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    UILabel *last = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, MAINWIDTH - 20, 50)];
    last.textColor = [UIColor grayColor];
    last.numberOfLines = 0;
    last.text = @"     感谢天外天全体成员的努力,©CopyRight 2015 天外天全体成员";
    last.font = [UIFont systemFontOfSize:13];
    last.textColor = [UIColor grayColor];
    [self.view addSubview:last];
    [last release];
    
    
}

- (void)press
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂时无登陆功能,我们会继续努力的" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

- (void)inpunt
{
    retroactionText.text = @"";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"感谢您的意见,我们一定会越做越好" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

#pragma mark - gesture

- (void)tap:(UITapGestureRecognizer *)tap
{
    [retroactionText resignFirstResponder];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = BARTINCOLOR;
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
