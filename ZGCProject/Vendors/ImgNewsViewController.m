//
//  ImgNewsViewController.m
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "ImgNewsViewController.h"
#import "ImgShowViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "DataSource.h"
#import "ImageModel.h"

@interface ImgNewsViewController ()<MyDelegate>

@end

@implementation ImgNewsViewController
{
    NSString *_identify;
    UICollectionView *collectionView1;
}

- (void)dealloc
{
    self.ProId = nil;
    self.serieasId = nil;
    self.imageArray = nil;
    [super dealloc];
}

- (void)requestImageView
{
    if ([_serieasId class] == nil) {
        _urlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/pic_tours/pic_only_list.php?pro_id=%@&size=640x960", _proId];
    } else {
    _urlString = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?&c=Iphone_37o_ProPics&noParam=1&proId=%@&seriesId=%@", _proId, _serieasId];
    }
    
    DataSource *dataSource = [[DataSource alloc] init];
    [dataSource readData:[NSURL URLWithString:_urlString]];
    dataSource.delegate = self;
    [dataSource release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"图片列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(returnBackThePage)];
    
    [self requestImageView];
    [self _init];
}

- (void)returnBackThePage
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_init{
    
    //为当前UICollectionView对象创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(110, 100);
    flowLayout.minimumLineSpacing = 6;
    flowLayout.minimumInteritemSpacing = 6;
    
    collectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 5) collectionViewLayout:flowLayout];
    collectionView1.dataSource = self;
    collectionView1.delegate = self;
    collectionView1.backgroundColor = [UIColor clearColor];
    collectionView1.showsVerticalScrollIndicator = NO;
    
    //注册单元格
    _identify = @"PhotoCell";
    [collectionView1 registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identify];
    
    [self.view addSubview:collectionView1];
    [collectionView1 release];
}

#pragma mark -请求数据
- (void)_requestData{
    
}

#pragma mark -UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

// 单元格代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];


        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.contentMode = UIViewContentModeScaleToFill;
        
        NSString *str = [_imageArray[indexPath.row] bigPicString];

        NSURL *url = [NSURL URLWithString:str];
        [imgView setImageWithURL:url];
        imgView.frame = CGRectMake(0, 0, 110, 90);
        imgView.layer.borderWidth = 0.5;
        
        [cell.contentView addSubview:imgView];
        [imgView release];
        
    return cell;
}



// 单元格选择代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 调用展示窗口
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (ImageModel *model in _imageArray) {

        [array addObject:model.bigPicString];
    }
    ImgShowViewController *imgShow = [[ImgShowViewController alloc] initWithSourceData:array withIndex:indexPath.row];
    [array release];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imgShow];
    UIAlertView *alertViewedd = [[UIAlertView alloc] initWithTitle:@"" message:@"长按图片以保存" delegate:nil cancelButtonTitle:@"So Cool" otherButtonTitles:nil];
    [alertViewedd show];
    [alertViewedd release];
    [self presentViewController:[nav autorelease] animated:YES completion:nil];
    [imgShow release];
}

#pragma mark -View生命周期
- (void)viewWillAppear:(BOOL)animated{

    // 导航栏不透明
    if (self.navigationController.navigationBar.translucent) {
        self.navigationController.navigationBar.translucent = NO;
    }

    // 隐藏导航栏
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
    
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:YES];
        }
    }

}

- (void)viewload:(id)response
{
    self.imageArray = [NSMutableArray arrayWithCapacity:0];
    if ([_serieasId class] == nil) {
        for (NSDictionary *dic in response[@"list"]) {
            ImageModel *image = [[ImageModel alloc] initWithDic:dic];
            [_imageArray addObject:image];
            [image release];
        }
    } else {
        for (NSDictionary *dic in response) {
            ImageModel *image = [[ImageModel alloc] initWithDic:dic];
            [_imageArray addObject:image];
            [image release];
        }
    }
    
    // 请求数据
    [self _requestData];
    [collectionView1 reloadData];
}




@end
