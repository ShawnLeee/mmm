//
//  DWAddInstructionViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpInstruction.h"
#import "DWAddInstructionViewModel.h"

@implementation DWAddInstructionViewModel
+ (instancetype)instructionViewModel
{
    DWAddInstructionViewModel *instrucitonViewModel = [[DWAddInstructionViewModel alloc] init];
    instrucitonViewModel.expInstruction = [DWAddExpInstruction expInstruction];
    return instrucitonViewModel;
}
- (NSMutableArray *)expExpStep
{
    if (!_expExpStep) {
        _expExpStep = [@[] mutableCopy];
    }
    return _expExpStep;
}
- (NSMutableArray *)expConsumable
{
    if (!_expConsumable) {
        _expConsumable = [NSMutableArray array];
    }
    return _expConsumable;
}
- (NSMutableArray *)expEquipment
{
    if (!_expEquipment) {
        _expEquipment = [NSMutableArray array];
    }
    return _expEquipment;
}
- (NSMutableArray *)expReagent
{
    if (!_expReagent) {
        _expReagent = [NSMutableArray array];
    }
    return _expReagent;
}
@end
