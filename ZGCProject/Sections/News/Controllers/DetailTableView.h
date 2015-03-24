//
//  DetailTableView.h
//  ZGCProject
//
//  Created by lanouhn on 15/1/11.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsViewController;
@class NewaDataHandle;


@interface DetailTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NewsViewController *newsViewController;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *totleArray;
@property (nonatomic, retain) NewaDataHandle *dataHandle;
@property (nonatomic, assign) NSInteger pageNumber;

- (void)currentTableView:(DetailTableView *)detaileTableView dataDic:(NSDictionary *)dataDic page:(NSInteger)pageNum;

@end
