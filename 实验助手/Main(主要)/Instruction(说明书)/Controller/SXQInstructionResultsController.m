//
//  SXQInstructionResultsController.m
//  实验助手
//
//  Created by sxq on 15/10/29.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQInstructionServiceImpl.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQInstructionResultsController.h"
#import "ArrayDataSource+TableView.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionDetailController.h"
@interface SXQInstructionResultsController ()

@property (nonatomic,strong) id<SXQInstructionService> service;
@property (nonatomic,strong) ArrayDataSource *arrayDataSource;
@property (nonatomic,weak) UINavigationController *nav;
@end

@implementation SXQInstructionResultsController
- (instancetype)initWithNavigationController:(UINavigationController *)nav
{
    if (self = [super init]) {
        _nav = nav;
    }
    return self;
}
- (id<SXQInstructionService>)service
{
    if (!_service) {
        _service = [[SXQInstructionServiceImpl alloc] init];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self binding];
    [self setupTableView];
}
- (void)setupTableView
{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _arrayDataSource = [[ArrayDataSource alloc] initWithItems:nil cellIdentifier:@"cell" cellConfigureBlock:^(UITableViewCell *cell,SXQExpInstruction  *detailItem) {
        cell.textLabel.text = detailItem.experimentName;
    }];
    self.tableView.dataSource = _arrayDataSource;
}
- (void)binding
{
    @weakify(self)
    [[[[[self searchBarTextSingal]
    map:^id(RACTuple *tuple) {
        return tuple.second;
    }]
    throttle:1.0]
    flattenMap:^RACStream *(NSString *text) {
        @strongify(self)
        return [[self.service getService] signalForSerchWithText:text];
    }]
    subscribeNext:^(NSArray *results) {
        @strongify(self)
        _arrayDataSource.items = results;
        [self.tableView reloadData];
    }
    error:^(NSError *error) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SXQExpInstruction *instruction = _arrayDataSource.items[indexPath.row];
    SXQInstructionDetailController *detailVC = [[SXQInstructionDetailController alloc] initWithInstruction:instruction];
    [self.nav pushViewController:detailVC animated:YES];
}
@end
