//
//  DWAddReagentViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSupplier.h"
#import "DWReagentSearchModel.h"
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
- (instancetype)initWithSearchModel:(DWReagentSearchModel *)searchModel
{
    if (self = [super init]) {
        self.firstClass = searchModel.levelOneSortName;
        self.secondClass = searchModel.levelTwoSortName;
        self.reagentName = searchModel.reagentName;
        self.supplier = [[searchModel.suppliers firstObject] supplierName];
        self.expReagent = [DWAddExpReagent new];
        self.expReagent.levelOneID = searchModel.levelOneSortID;
        self.expReagent.levelTwoID = searchModel.levelTwoSortID;
        self.expReagent.reagentID = searchModel.reagentID;
        self.expReagent.reagentName = searchModel.reagentName;
        self.expReagent.supplier = [searchModel.suppliers firstObject];
    }
    return self;
}
@end
