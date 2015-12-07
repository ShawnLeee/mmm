//
//  DWMeViewController.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWSignOutView.h"
#import "DWMeEditController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeHeader.h"
#import "DWMeServiceImpl.h"
#import "DWMeViewController.h"
#import "DWMeCell.h"
#import "DWMeItem.h"

@interface DWMeViewController ()<DWMeHeaderDelegate>
@property (nonatomic,strong) id<DWMeService> service;
@property (nonatomic,strong) NSArray *meItems;
@end

@implementation DWMeViewController
- (NSArray *)meItems
{
    if (!_meItems) {
        _meItems = @[];
    }
    return _meItems;
}
- (id<DWMeService>)service
{
    if (!_service) {
        _service = [[DWMeServiceImpl alloc] init];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadMeItemsData];
    [self p_setupTableView];
    [self p_setupTableHeader];
    [self p_setupTableFooter];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWMeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWMeCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (void)p_setupTableFooter
{
    DWSignOutView *signOutView = [[DWSignOutView alloc] initWithService:self.service];
    self.tableView.tableFooterView = signOutView;
}
- (void)p_setupTableHeader
{
    DWMeHeader *meHeader = [[DWMeHeader alloc] init];
    meHeader.delegate = self;
    self.tableView.tableHeaderView = meHeader;
}
- (void)p_loadMeItemsData
{
    @weakify(self)
    [[self.service meItemsSignal]
     subscribeNext:^(NSArray *meItems) {
         @strongify(self)
         self.meItems = meItems;
         [self.tableView reloadData];
    }];
}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWMeCell class]) forIndexPath:indexPath];
    cell.meItem = self.meItems[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    footer.backgroundColor = [UIColor  clearColor];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWMeItem *item = self.meItems[indexPath.row];
    [self performSegueWithIdentifier:item.segueIdentifier sender:nil];
}
#pragma mark - HeaderDelegate
- (void)dw_meHeader:(DWMeHeader *)header didClickedHeaderButton:(UIButton *)button
{
    [self performSegueWithIdentifier:NSStringFromClass([DWMeEditController class]) sender:button];
}
@end
