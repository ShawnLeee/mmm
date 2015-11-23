//
//  SXQDoneExperimentController.m
//  实验助手
//
//  Created by sxq on 15/9/14.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
#import "DWDoingCell.h"
#import "SXQDoneExperimentController.h"
#import "SXQExperimentModel.h"
#import "DWDoingViewModel.h"
#import "ExperimentTool.h"
#import "DWDoingViewModelServiceImpl.h"
#import "DWMyExperimentServicesImpl.h"
#import "SXQDBManager.h"
#import "ArrayDataSource+TableView.h"
@interface SXQDoneExperimentController ()
@property (nonatomic,strong) NSArray *experiments;
@property (nonatomic,strong) id<DWDoingModelService> service;
@property (nonatomic,strong) id<DWMyExperimentServices> experimentService;
@property (nonatomic,strong) ArrayDataSource *arrayDataSource;
@end

@implementation SXQDoneExperimentController
- (id<DWMyExperimentServices>)experimentService
{
    if (!_experimentService) {
        _experimentService = [DWMyExperimentServicesImpl new];
    }
    return _experimentService;
}
- (id<DWDoingModelService>)service
{
    if (!_service) {
        _service = [[DWDoingViewModelServiceImpl alloc] initWithTableViewController:self];
    }
    return _service;
}
- (NSArray *)experiments
{
    if (!_experiments) {
        _experiments = @[];
    }
    return _experiments;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.experiments = [self modelToViewModel:[[SXQDBManager sharedManager] fetchExperimentWithState:ExperimentStateDown]];
    _arrayDataSource.items = self.experiments;
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTable];
    
}

- (void)p_setupTable
{
    NSString *cellIdentifier = NSStringFromClass([DWDoingCell class]);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight =  100;
    self.tableView.allowsSelection = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWDoingCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    _arrayDataSource = [[ArrayDataSource alloc] initWithItems:self.experiments cellIdentifier:cellIdentifier cellConfigureBlock:^(DWDoingCell *cell,DWDoingViewModel *viewModel) {
        cell.viewModel = viewModel;
    }];
    self.tableView.dataSource = _arrayDataSource;
}

#pragma mark - TableView Delegate Method
- (NSArray *)modelToViewModel:(NSArray *)modelArray
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [modelArray enumerateObjectsUsingBlock:^(SXQExperimentModel *experimentModel, NSUInteger idx, BOOL * _Nonnull stop) {
        DWDoingViewModel *viewModel = [[DWDoingViewModel alloc] initWithExperimentModel:experimentModel];
        viewModel.service = self.service;
        viewModel.experimentService = self.experimentService;
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
@end
