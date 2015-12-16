//
//  DWAddStepController.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddStepViewModel.h"
#import "DWAddStepCell.h"
#import "DWAddStepController.h"
#import "DWAddStepFooter.h"

@interface DWAddStepController ()
@property (nonatomic,strong) NSMutableArray *addedSteps;
@end

@implementation DWAddStepController
- (NSMutableArray *)addedSteps
{
    if (!_addedSteps) {
        _addedSteps = [NSMutableArray array];
    }
    if (_addedSteps.count == 0) {
        DWAddStepViewModel *stepViewModel = [[DWAddStepViewModel alloc] initWithStepNum:1];
        [_addedSteps addObject:stepViewModel];
    }
    return _addedSteps;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
}
- (void)p_setupTableView
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.allowsSelection = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWAddStepCell class]) bundle:nil]
         forCellReuseIdentifier:NSStringFromClass([DWAddStepCell class])];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_dismissKeyboard:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [self p_setupTableFooter];
    
}
- (void)p_dismissKeyboard:(UITapGestureRecognizer *)tapReconizer
{
    [self.view endEditing:YES];
}

- (void)p_setupTableFooter
{
    typeof(self) weakSelf = self;
    DWAddStepFooter *stepFooter = [[DWAddStepFooter alloc] initWithAddHandler:^{
        DWAddStepViewModel *stepViewModel = [[DWAddStepViewModel alloc] initWithStepNum:(self.addedSteps.count + 1)];
        [weakSelf.addedSteps addObject:stepViewModel];
        [weakSelf.tableView reloadData];
    }];
    self.tableView.tableFooterView = stepFooter;
    self.tableView.tableFooterView.frame = CGRectMake(0, 0, 300, 54);
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addedSteps.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWAddStepViewModel *stepViewModel = self.addedSteps[indexPath.row];
    DWAddStepCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddStepCell class]) forIndexPath:indexPath];
    cell.tableView = self.tableView;
    cell.stepViewModel = stepViewModel;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

@end
