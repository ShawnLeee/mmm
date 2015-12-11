//
//  DWAddReagentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpReagent.h"
#import "DWAddReagentViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddItemToolImpl.h"
@interface DWAddReagentViewModel ()
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@end
@implementation DWAddReagentViewModel
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [[DWAddItemToolImpl alloc] init];
    }
    return _addItemTool;
}

+ (instancetype)reagentViewModel
{
    DWAddReagentViewModel *viewModel = [[DWAddReagentViewModel alloc] init];
    viewModel.expReagent = [DWAddExpReagent new];
    [viewModel bingModel];
    return viewModel;
}
- (void)bingModel
{
    RAC(self.expReagent,reagentName) = RACObserve(self, reagentName);
    RAC(self.expReagent,useAmount) = RACObserve(self, amount);
}
@end
