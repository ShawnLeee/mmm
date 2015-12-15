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
@end
