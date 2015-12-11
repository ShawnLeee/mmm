//
//  DWAddReagentController.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddReagentCell.h"
#import "DWAddReagentViewModel.h"
#import "DWAddReagentController.h"
#import "UIBarButtonItem+SXQ.h"
#import "UIBarButtonItem+MJ.h"
#import "DWAddExpReagent.h"

@interface DWAddReagentController ()
@property (nonatomic,strong) DWAddReagentViewModel *reagentViewModel;
@end

@implementation DWAddReagentController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_setupViewModel];
    [self p_setupNavigationBar];
    
}
#pragma mark - Private Helper Method
- (void)p_setupTableView
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWAddReagentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWAddReagentCell class])];
}
- (void)p_setupViewModel
{
    self.reagentViewModel = [DWAddReagentViewModel reagentViewModel];
    self.reagentViewModel.expReagent.expInstructionID = self.instrucitonID;
}
- (void)p_setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"Cancel_Normal" highIcon:@"Cancel_Highlight" target:self action:@selector(disMissSelf)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" titleColor:MainBgColor font:15 action:^{
        if (self.reagentViewModel.expReagent.reagentID) {
            self.doneBlock(self.reagentViewModel);
        }
        [self disMissSelf];
    }];
}
- (void)disMissSelf
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - TableView DataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWAddReagentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWAddReagentCell class]) forIndexPath:indexPath];
    cell.reagentViewModel = self.reagentViewModel;
    return cell;
}
@end
