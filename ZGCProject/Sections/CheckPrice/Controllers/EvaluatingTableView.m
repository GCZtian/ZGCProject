//
//  EvaluatingTableView.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/15.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "EvaluatingTableView.h"
#import "EvaluatingTableViewCell.h"
#import "PICTableViewCell.h"
#import "DataSource.h"
#import "News.h"
#import "Evaluating.h"
#import "DetailViewController.h"
#import "PostViewController.h"
#import "ImgNewsViewController.h"
#import "UIImageView+WebCache.h"


static NSString *evaluatingCell = @"cell";
static NSString *PicTableCell = @"picCell";

@interface EvaluatingTableView ()<MyDelegate>

@end
@implementation EvaluatingTableView

- (void)dealloc
{
    self.proID = nil;
    self.seriesId = nil;
    self.data = nil;
    self.commenArray = nil;
    self.picSrcArray = nil;
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setProID:(NSString *)proID
{
    if (_proID != proID) {
        [_proID release];
        _proID = [proID retain];
    }
    self.data = [[DataSource alloc] init];
    if (_proID != nil && _seriesId != 0) {
         self.url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_EvalDoc&proId=%@&seriesId=%@&page=1&verParam=383", _proID, _seriesId];
    } else if (_proID != nil && _seriesId == 0) {
        self.url = [NSString stringWithFormat:@"http://lib3.wap.zol.com.cn/index.php?c=Iphone_37o_EvalDoc&proId=%@&seriesId=&page=1&verParam=383", _proID];
    }
    [self.data readData:[NSURL URLWithString:_url]];
        _data.delegate = self;
        [_data release];
        
        self.showsVerticalScrollIndicator = NO;
        self.tableFooterView = [UIView new];
        
        [self reloadData];
        
        [self registerClass:[EvaluatingTableViewCell class] forCellReuseIdentifier:evaluatingCell];
        
        [self registerClass:[PICTableViewCell class] forCellReuseIdentifier:PicTableCell];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_picSrcArray != nil) {
        return _commenArray.count + 1;
    }
    return _commenArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_picSrcArray != nil && indexPath.row == 0) {
        PICTableViewCell *picCell = [tableView dequeueReusableCellWithIdentifier:PicTableCell forIndexPath:indexPath];
        
        
        picCell.picTitle.text = _titileArray[0];
        
        Evaluating *evalua = _picSrcArray[0];
        [picCell.imageViewOne sd_setImageWithURL:[NSURL URLWithString:evalua.picSrcOne]];
        evalua = _picSrcArray[1];
        [picCell.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:evalua.picSrcOne]];
        evalua = _picSrcArray[2];
        [picCell.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:evalua.picSrcOne]];
        
        return picCell;
    } else {
        EvaluatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluatingCell forIndexPath:indexPath];
        if (_picSrcArray == nil) {
            News *new = (News *)_commenArray[indexPath.row];
            cell.news = new;
        } else {
            News *new = (News *)_commenArray[indexPath.row - 1];
            cell.news = new;
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_picSrcArray != nil && indexPath.row == 0) {
        return 115;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostViewController *post = [[PostViewController alloc] init];
    if (_picSrcArray == nil) {
        _url = ((News *)_commenArray[indexPath.row]).docId;
        post.commentNum = ((News *)_commenArray[indexPath.row]).reviewNum;
        post.iD = ((News *)_commenArray[indexPath.row]).docId;
        post.webUrlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/client_article.php?id=%@&tag=0&picOpen=1&fontSize=small&vs=iph382", _url];
        [self.detial.navigationController pushViewController:post animated:YES];
    } else {
        if (indexPath.row != 0) {
            _url = ((News *)_commenArray[indexPath.row - 1]).docId;
            post.commentNum = ((News *)_commenArray[indexPath.row - 1]).reviewNum;
            post.iD = ((News *)_commenArray[indexPath.row - 1]).docId;
            post.webUrlString = [NSString stringWithFormat:@"http://lib.wap.zol.com.cn/ipj/client_article.php?id=%@&tag=0&picOpen=1&fontSize=small&vs=iph382", _url];
            [self.detial.navigationController pushViewController:post animated:YES];
        } else {
            ImgNewsViewController *iamge = [[ImgNewsViewController alloc] init];
            iamge.proId = ((Evaluating *)_picSrcArray[0]).proId;
            [self.detial.navigationController pushViewController:iamge animated:YES];
            [iamge release];
        }
    }
}

#pragma mark - MyDelegate

- (void)viewload:(id)response
{
    if ([response[@"evalDoc"] count] > 0) {
        self.commenArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in response[@"evalDoc"]) {
            News *news = [[News alloc] initWithDic:dic];
            [_commenArray addObject:news];
            [news release];
        }
    }
    if (response[@"evalPic"] != nil) {
        self.titileArray = [NSMutableArray arrayWithCapacity:0];
        self.picSrcArray = [NSMutableArray arrayWithCapacity:0];
        for (NSString *key in response[@"evalPic"]) {
            if ([key isEqualToString:@"title"]) {
                [_titileArray addObject:response[@"evalPic"][key]];
            }
        }
            for (NSDictionary *dict in response[@"evalPic"][@"pics"]) {
                Evaluating *eval = [[Evaluating alloc] initWithDic:dict];
                [self.picSrcArray addObject:eval];
            }
        }
    if (_commenArray == nil && response[@"evalPic"] == nil) {
        UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100) / 2.0, ([UIScreen mainScreen].bounds.size.height - 140) / 2.0 - 100, 100, 100)];
        iamgeView.image = [UIImage imageNamed:@"icon_pl_noresult_grayback"];
        [self.tableFooterView addSubview:iamgeView];
        [iamgeView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 150) / 2.0 + 5, ([UIScreen mainScreen].bounds.size.height - 70) / 2.0, 150, 30)];
        label.text = @"该产品下暂无评测";
        label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self.tableFooterView addSubview:label];
        [label release];
    }
    [self reloadData];
}
@end
