//
//  MakeOffersView.m
//  ZGCProject
//
//  Created by Tsummer on 15/1/14.
//  Copyright (c) 2015年 niutiantian. All rights reserved.
//

#import "MakeOffersView.h"
#import "ExtraProsDataSource.h"
#import "WebViewController.h"
#import "DetailViewController.h"
#import "TableViewController.h"
@implementation MakeOffersView

- (void)dealloc
{
    self.sectionArray = nil;
    self.titleNameArray = nil;
    self.detai = nil;
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
            self.delegate = self;
            self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)setSectionArray:(NSMutableArray *)sectionArray
{
    if (_sectionArray != sectionArray) {
        [_sectionArray release];
        _sectionArray = [sectionArray retain];
    }
    if (_sectionArray != nil) {
        [self reloadData];
    }
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleNameArray[section] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if (indexPath.row > 0) {
        ExtraProsDataSource *tableCell = (ExtraProsDataSource *)[_titleNameArray[indexPath.section] objectAtIndex:indexPath.row - 1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = tableCell.priceName;
        cell.detailTextLabel.text = tableCell.price;
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    } else {
        ExtraProsDataSource *tableCell = (ExtraProsDataSource *)_sectionArray[indexPath.section];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.textLabel.text = tableCell.name;
        
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        ExtraProsDataSource *data = (ExtraProsDataSource *)_sectionArray[indexPath.section];
        cell.textLabel.frame = CGRectMake(0, 5, 350, 40);
        cell.textLabel.text = data.name;
        cell.textLabel.numberOfLines = 0;
        return [self heighOfStrings:cell.textLabel.text];
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        WebViewController *webView = [[WebViewController alloc] init];
        [_detai.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:23]}];
        [_detai.navigationController pushViewController:webView animated:YES];
        webView.ProdId = ((ExtraProsDataSource *)[_titleNameArray[indexPath.section] objectAtIndex:indexPath.row - 1]).proId;
        [webView release];
    }
}

//自适应行高
- (CGFloat)heighOfStrings:(NSString *)aString
{
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(350, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
    return rect.size.height + 20;
}

@end
