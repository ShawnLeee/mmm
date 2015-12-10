//
//  DWAddReagentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpReagent.h"
#import "DWAddReagentViewModel.h"

@implementation DWAddReagentViewModel
+ (instancetype)reagentViewModel
{
    DWAddReagentViewModel *viewModel = [[DWAddReagentViewModel alloc] init];
    viewModel.expReagent = [DWAddExpReagent new];
    return viewModel;
}
@end
