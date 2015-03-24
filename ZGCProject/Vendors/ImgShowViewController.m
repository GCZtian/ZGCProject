//
//  ImgShowViewController.m
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "ImgShowViewController.h"
#import "MRImgShowView.h"

@interface ImgShowViewController ()<UIAlertViewDelegate>

@end

@implementation ImgShowViewController

- (id)initWithSourceData:(NSMutableArray *)data withIndex:(NSInteger)index{
    
    self = [super init];
    if (self) {
        [self init];
        self.data = [[NSMutableArray alloc] initWithArray:data];
        _index = index;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)dealloc{
    
    [_data release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"图片列表";
    
    //设置导航栏为半透明
    self.navigationController.navigationBar.translucent = YES;
    // 隐藏标签栏
    self.tabBarController.tabBar.hidden = YES;

    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
    // 添加导航栏退回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"<- Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    [backItem release];
    
    [self creatImgShow];
}

// 初始化视图
- (void)creatImgShow{
    
    MRImgShowView *imgShowView = [[MRImgShowView alloc]
                                  initWithFrame:self.view.frame
                                    withSourceData:_data
                                    withIndex:_index];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imgShowView addGestureRecognizer:longPress];
    [longPress release];
    

    // 解决谦让
    [imgShowView requireDoubleGestureRecognizer:[[self.view gestureRecognizers] lastObject]];
    
    [self.view addSubview:imgShowView];
}

- (void)longPress:(UILongPressGestureRecognizer *)press
{
    if (press.state == UIGestureRecognizerStateBegan) {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"是否保存图片(想好了哦亲)" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.delegate = self;
    [alertView show];
    [alertView release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (buttonIndex == 0) {
        
            //viewImage就是获取的截图，如果要将图片存入相册，只需在后面调用
            //         UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
            UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else {
        UIAlertView *alertViewedd = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"确定要退出保存了吗亲" delegate:nil cancelButtonTitle:@"Yes! Yes! Yes!" otherButtonTitles:nil];
        [alertViewedd show];
        [alertViewedd release];
    }

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alertViewed = [[UIAlertView alloc] initWithTitle:@"保存成功" message:@"你的选择屌爆了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertViewed show];
    [alertViewed release];
}

- (void)jinggao
{
    UIAlertView *alertViewedd = [[UIAlertView alloc] initWithTitle:@"" message:@"保存失败" delegate:nil cancelButtonTitle:@"I Know" otherButtonTitles:nil];
    [alertViewedd show];
    [alertViewedd release];
}


#pragma mark -UIGestureReconginzer
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 隐藏导航栏
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    }];

}

#pragma mark -NavAction
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
